import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ride_glide/constants.dart';
import 'package:ride_glide/core/errors/Faluire_model.dart';
import 'package:ride_glide/core/utils/api_service.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';
import 'package:ride_glide/features/Home/data/models/place_auto_complete_model/place_auto_complete_model.dart';
import 'package:ride_glide/features/Home/data/models/place_details_model/place_details_model.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  static const String stripePublishablekey = kStripePuplishKey;
  final String stripeSecretkey = kStripeSecretKey;
  final String types = 'geocode';
  final firestore = FirebaseFirestore.instance;

  HomeRepoImpl({required this.apiService});
  @override
  Future<Either<Faluire, List<DriverModel>>>
      checkForNearbyOnlineDrivers() async {
    try {
      final driversCollection =
          FirebaseFirestore.instance.collection('Drivers');

      final query = driversCollection.where('status', isEqualTo: true);
      final querySnapshot = await query.get();
      final onlineDrivers = querySnapshot.docs;
      List<DriverModel> onlineDriversList = [];

      for (var driverSnapshot in onlineDrivers) {
        // Extract driver data from the snapshot and create a DriverModel instance
        Map<String, dynamic> driverData = driverSnapshot.data();
        DriverModel driver = DriverModel.fromFireStore(driverData);

        onlineDriversList.add(driver);
      }

      return Right(onlineDriversList);
    } catch (e) {
      return Left(FirbaseFaluire.fromFirebaseAuth(e.toString()));
    }
  }

  @override
  Future<Either<Faluire, List<PlaceAutoCompleteModel>>> getAutoComplete(
      {required String searchInput}) async {
    try {
      var data = await apiService.get(
          url:
              'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&components=country:EG&key=$kGoogleKey');

      List<PlaceAutoCompleteModel> placesList = [];
      debugPrint('this is theeee  no ListTTTTTTTTTTTTTT====== $placesList');
      for (var item in data["predictions"]) {
        placesList.add(PlaceAutoCompleteModel.fromJson(item));
      }

      debugPrint('this is theeee  no ListTTTTTTTTTTTTTT====== $placesList');

      return right(placesList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaliure.fromDioErr(e));
      }
      return left(ServerFaliure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Faluire, PlaceDetailsModel>> getPlaceDeatils(
      {required String placeID}) async {
    try {
      var data = await apiService.get(
          url:
              'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&fields=name,geometry,formatted_address,website,reviews&key=$kGoogleKey');
      debugPrint(
          'THIS IS THE HHHHHHHHHHHHHHHHHHHHHHTTTTTTTTTTTTTTTYYYYYYY     ${PlaceDetailsModel.fromJson(data)}');
      return right(PlaceDetailsModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaliure.fromDioErr(e));
      }
      return left(ServerFaliure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Faluire, String?>> getPlaceId(
      {required double latitude, required double longitude}) async {
    try {
      var data = await apiService.get(
          url:
              'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$kGoogleKey');

      final placeId = data['results'][0]['place_id'];

      return right(placeId);
    } catch (e) {
      return left(ServerFaliure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Faluire, PlaceDetailsModel>> getPlaceDetailsfromLocation(
      {required double latitude, required double longitude}) async {
    try {
      final placeId =
          await getPlaceId(latitude: latitude, longitude: longitude);

      // Use fold to handle both success and failure cases
      return placeId.fold(
        (failure) {
          // Handle the failure case here and return an appropriate result
          return left(ServerFaliure(errMessage: failure.toString()));
        },
        (placeId) async {
          // Call getPlaceDetails with the extracted placeId
          final placeDetailsResult =
              await getPlaceDeatils(placeID: placeId ?? '');

          // Handle the result of getPlaceDetails and return it
          return placeDetailsResult.fold(
            (failure) {
              // Handle the failure case from getPlaceDetails here and return an appropriate result
              return left(ServerFaliure(errMessage: failure.toString()));
            },
            (placeDetails) {
              // Return the successful result from getPlaceDetails

              return right(placeDetails);
            },
          );
        },
      );
    } catch (e) {
      return left(ServerFaliure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Faluire, String?>> getPlaceName(
      {required double latitude, required double longitude}) async {
    try {
      var data = await apiService.get(
          url:
              'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$kGoogleKey');
      final placeId = data['results'][0]["formatted_address"];

      return right(truncateStringAfterWords(placeId, 10));
    } catch (e) {
      return left(ServerFaliure(errMessage: e.toString()));
    }
  }

  String truncateStringAfterWords(String input, int wordLimit) {
    // Split the input string into words using space as the delimiter
    List<String> words = input.split(' ');

    // If the number of words is less than or equal to the wordLimit, return the original string
    if (words.length <= wordLimit) {
      return input;
    }

    // Take only the first wordLimit words and join them back together with spaces
    List<String> truncatedWords = words.take(wordLimit).toList();
    return truncatedWords.join(' ');
  }

  @override
  Future<Either<Faluire, String?>> getClientSecret(
      {required int amount, required String currency}) async {
    try {
      var responce = await Dio().post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer $stripeSecretkey',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {
          'amount': amount, // Replace with the desired amount in cents
          'currency': currency, // Replace with the desired currency
        },
      );
      debugPrint(
          'THIS IS THE SECREETTTT=====()(==   ${responce.data["client_secret"]})');
      return right(responce.data["client_secret"]);
    } catch (e) {
      debugPrint('THIS IS THE SECREETTTT=====()(======  ${e.toString()}  ');
      return left(ServerFaliure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Faluire, void>> makePayment(
      {required int amount, required String currency}) async {
    try {
      var clientSecret =
          await getClientSecret(amount: (amount * 100), currency: currency);
      clientSecret.fold((faluire) {
        return left(ServerFaliure(errMessage: faluire.toString()));
      }, (clientSecret) async {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              customFlow: true,
              paymentIntentClientSecret: clientSecret,
              merchantDisplayName: 'Ahmed'),
        );
        await Stripe.instance.presentPaymentSheet();
      });
      return right(amount);
    } catch (e) {
      return left(ServerFaliure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Faluire, void>> requestNewRide(
      {required String locationAddress,
      required String destinationAddress,
      required String time,
      required String ridePrice,
      required String userUid,
      required String clientName,
      required String clienImageUrl,
      required String paymentMethod,
      required String driverUID,
      required double lat,
      required double lng}) async {
    try {
      final ridesRef = firestore.collection('Rides').doc(auth.currentUser?.uid);
      await ridesRef.set({
        'locationAddress': locationAddress,
        'destinationAddress': destinationAddress,
        'time': time,
        'ridePrice': ridePrice,
        'userUid': userUid,
        'clientName': clientName,
        'clienImageUrl': clienImageUrl,
        'paymentMethod': paymentMethod,
        'driverUID': driverUID,
        'lat': lat,
        'lng': lng
      });
      return right(null);
    } catch (e) {
      return left(FirbaseFaluire.fromFirebaseAuth(e.toString()));
    }
  }

  static Stream<bool?> listenForRideConfirmation({required String rideId}) {
    try {
      final DocumentReference rideDocRef =
          FirebaseFirestore.instance.collection('Rides').doc(rideId);

      final Stream<bool?> rideConfirmationStream =
          rideDocRef.snapshots().map((snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;
        final rideStatus = data[
            'status']; // Assuming you store the ride status in a field named 'status'

        if (rideStatus == true) {
          return true;
        } else if (rideStatus == false) {
          return false;
        } else {
          // Handle other statuses if necessary
          return null; // Default to null for unknown statuses
        }
      });

      return rideConfirmationStream;
    } catch (e) {
      return Stream.error('Error: $e');
    }
  }

  static Future<Either<Faluire, void>> deleteTHeRide(
      {required String uid}) async {
    try {
      final ridesRef = FirebaseFirestore.instance.collection('Rides').doc(uid);
      await ridesRef.delete();
      return right(null);
    } catch (e) {
      return left(FirbaseFaluire.fromFirebaseAuth(e.toString()));
    }
  }
}

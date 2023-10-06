import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ride_glide/core/errors/Faluire_model.dart';
import 'package:ride_glide/core/utils/api_service.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';
import 'package:ride_glide/features/Home/data/models/place_auto_complete_model/place_auto_complete_model.dart';
import 'package:ride_glide/features/Home/data/models/place_details_model/place_details_model.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;
  final String key = 'AIzaSyCwAe3qJC0pDaLbovyNykTSLRaY5r7N--g';
  static const String stripePublishablekey =
      'pk_test_51NyEvAEAdvIVZRwI3TmwwS8BxtSlr5g7XFW6JqS1gtXfb9rBSA3K7BYR1ofoDNTyURg0yZgQAC7pynV269gkMWlj00bKgQFimg';
  final String stripeSecretkey =
      'sk_test_51NyEvAEAdvIVZRwIxFgdtKshjB7IevsCAzDQpBfLQNdd1WPUcNwe0JOLZJBTwu6rd2wfKUbVxpPh5RI2Oe3FGpSK004tCJI1XV';
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
              'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&components=country:EG&key=$key');

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
              'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&fields=name,geometry,formatted_address,website,reviews&key=$key');
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
              'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$key');
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
              'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$key');
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
        await Stripe.instance.confirmPaymentSheetPayment();
      });
      return right(amount);
    } catch (e) {
      return left(ServerFaliure(errMessage: e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:ride_glide/core/errors/Faluire_model.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';
import 'package:ride_glide/features/Home/data/models/place_auto_complete_model/place_auto_complete_model.dart';
import 'package:ride_glide/features/Home/data/models/place_details_model/place_details_model.dart';

abstract class HomeRepo {
  Future<Either<Faluire, List<PlaceAutoCompleteModel>>> getAutoComplete(
      {required String searchInput});
  Future<Either<Faluire, PlaceDetailsModel>> getPlaceDeatils(
      {required String placeID});
  Future<Either<Faluire, String?>> getPlaceId(
      {required double latitude, required double longitude});
  Future<Either<Faluire, String?>> getPlaceName(
      {required double latitude, required double longitude});
  Future<Either<Faluire, List<DriverModel>>> checkForNearbyOnlineDrivers();
  Future<Either<Faluire, PlaceDetailsModel>> getPlaceDetailsfromLocation(
      {required double latitude, required double longitude});
  Future<Either<Faluire, String?>> getClientSecret(
      {required int amount, required String currency});
  Future<Either<Faluire, void>> makePayment(
      {required int amount, required String currency});
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
      required double lng});
}

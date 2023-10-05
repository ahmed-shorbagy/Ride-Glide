import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/Home/data/models/place_details_model/place_details_model.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo.dart';

part 'pick_destination_state.dart';

class PickDestinationCubit extends Cubit<PickDestinationState> {
  PickDestinationCubit(this.homeRepo) : super(PickDestinationInitial());
  final HomeRepo homeRepo;
  static TextEditingController destinationPlacecontroller =
      TextEditingController();

  static PlaceDetailsModel? destination;

  Future<void> getPlaceDetailsFromLocation(
      {required double latitude, required double longitude}) async {
    emit(PickDestinationLoading());
    var responce = await homeRepo.getPlaceDetailsfromLocation(
        latitude: latitude, longitude: longitude);
    responce.fold((faluire) {
      emit(PickDestinationFaluire(errMessage: faluire.errMessage));
    }, (placeDetails) {
      emit(PickDestinationSuccess(placeDetails: placeDetails));
    });
  }

  Future<void> getPlaceDetails({required String placeID}) async {
    emit(PickDestinationLoading());
    var responce = await homeRepo.getPlaceDeatils(placeID: placeID);
    responce.fold((faluire) {
      emit(PickDestinationFaluire(errMessage: faluire.errMessage));
    }, (placeDetails) {
      emit(PickDestinationSuccess(placeDetails: placeDetails));
    });
  }
}

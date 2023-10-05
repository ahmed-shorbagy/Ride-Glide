import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/Home/data/models/place_details_model/place_details_model.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo.dart';

part 'pick_location_state.dart';

class PickLocationCubit extends Cubit<PickLocationState> {
  PickLocationCubit(this.homeRepo) : super(PickLocationInitial());
  final HomeRepo homeRepo;
  static TextEditingController locationPlaceController =
      TextEditingController();

  static PlaceDetailsModel? location;

  Future<void> getPlaceDetailsFromLocation(
      {required double latitude, required double longitude}) async {
    emit(PickLocationLoading());
    var responce = await homeRepo.getPlaceDetailsfromLocation(
        latitude: latitude, longitude: longitude);
    responce.fold((faluire) {
      emit(PickLocationFaluire(errmessage: faluire.errMessage));
    }, (placeDetails) {
      emit(PickLocationSucceess(placeDetails: placeDetails));
    });
  }

  Future<void> getPlaceDetails({required String placeID}) async {
    emit(PickLocationLoading());
    var responce = await homeRepo.getPlaceDeatils(placeID: placeID);
    responce.fold((faluire) {
      emit(PickLocationFaluire(errmessage: faluire.errMessage));
    }, (placeDetails) {
      emit(PickLocationSucceess(placeDetails: placeDetails));
    });
  }
}

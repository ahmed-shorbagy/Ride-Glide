import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo.dart';

part 'online_drivers_state.dart';

class OnlineDriversCubit extends Cubit<OnlineDriversState> {
  OnlineDriversCubit(this.homeRepo) : super(OnlineDriversInitial());
  final HomeRepo homeRepo;
  Future<void> checkForOnlineDrivers() async {
    emit(OnlineDriversLoading());
    var onlineDrivers = await homeRepo.checkForNearbyOnlineDrivers();
    onlineDrivers.fold((faluire) {
      emit(OnlineDriversFaluire(erMessage: faluire.errMessage));
    }, (onlineDrivers) {
      emit(OnlineDriversSuccess(onlineDrivers: onlineDrivers));
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo.dart';

part 'ride_requests_state.dart';

class RideRequestsCubit extends Cubit<RideRequestsState> {
  RideRequestsCubit(this.homeRepo) : super(RideRequestsInitial());
  final HomeRepo homeRepo;
  Future<void> requestNewRide(
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
    emit(RideRequestsLoading());
    var request = await homeRepo.requestNewRide(
        driverUID: driverUID,
        locationAddress: locationAddress,
        destinationAddress: destinationAddress,
        time: time,
        ridePrice: ridePrice,
        userUid: userUid,
        clientName: clientName,
        clienImageUrl: clienImageUrl,
        paymentMethod: paymentMethod,
        lat: lat,
        lng: lng);

    request.fold((faluire) {
      emit(RideRequestsFaluire(errMessage: faluire.errMessage));
    }, (requestSuccess) {
      emit(RideRequestsSuccess());
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/Home/data/models/place_details_model/place_details_model.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_destination_cubit/pick_destination_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_location_cubit/pick_location_cubit.dart';

part 'place_details_cubit_state.dart';

class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  PlaceDetailsCubit(this.homeRepo) : super(PlaceDetailsCubitInitial());
  final HomeRepo homeRepo;
  Future<void> getPlaceDetails({required String placeID}) async {
    emit(PlaceDetailsCubitLoading());
    var responce = await homeRepo.getPlaceDeatils(placeID: placeID);
    responce.fold((faluire) {
      emit(PlaceDetailsCubitFaluire(errMessage: faluire.errMessage));
    }, (placeDetails) {
      emit(PlaceDetailsCubitSuccess(placeDetails: placeDetails));
    });
  }

  void notifyCustomButton() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (PickDestinationCubit.destination != null &&
            PickLocationCubit.location != null) {
          emit(PlaceDetailsCubitLocationDestnationSelected());
        }
      },
    );
  }
}

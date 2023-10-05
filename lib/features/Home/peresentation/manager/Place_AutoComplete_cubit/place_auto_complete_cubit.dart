import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/Home/data/models/place_auto_complete_model/place_auto_complete_model.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo.dart';

part 'place_auto_complete_state.dart';

class PlaceAutoCompleteCubit extends Cubit<PlaceAutoCompleteState> {
  PlaceAutoCompleteCubit(this.homeRepo) : super(PlaceAutoCompleteInitial());
  final HomeRepo homeRepo;

  Future<void> placeAutoComplete({required String searchedInput}) async {
    emit(PlaceAutoCompleteLoading());
    var responce = await homeRepo.getAutoComplete(searchInput: searchedInput);
    responce.fold((faluire) {
      emit(PlaceAutoCompleteFaluire(errMessage: faluire.errMessage));
    }, (placesSuggestions) {
      emit(PlaceAutoCompleteSuccess(placesSuggestionList: placesSuggestions));
    });
  }
}

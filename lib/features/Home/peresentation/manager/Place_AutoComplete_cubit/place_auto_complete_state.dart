part of 'place_auto_complete_cubit.dart';

@immutable
sealed class PlaceAutoCompleteState {}

final class PlaceAutoCompleteInitial extends PlaceAutoCompleteState {}

final class PlaceAutoCompleteLoading extends PlaceAutoCompleteState {}

final class PlaceAutoCompleteSuccess extends PlaceAutoCompleteState {
  final List<PlaceAutoCompleteModel> placesSuggestionList;

  PlaceAutoCompleteSuccess({required this.placesSuggestionList});
}

final class PlaceAutoCompleteFaluire extends PlaceAutoCompleteState {
  final String errMessage;

  PlaceAutoCompleteFaluire({required this.errMessage});
}

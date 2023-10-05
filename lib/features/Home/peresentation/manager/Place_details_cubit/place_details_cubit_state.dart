part of 'place_details_cubit_cubit.dart';

@immutable
sealed class PlaceDetailsState {}

final class PlaceDetailsCubitInitial extends PlaceDetailsState {}

final class PlaceDetailsCubitLoading extends PlaceDetailsState {}

final class PlaceDetailsCubitSuccess extends PlaceDetailsState {
  final PlaceDetailsModel placeDetails;

  PlaceDetailsCubitSuccess({required this.placeDetails});
}

final class PlaceDetailsCubitFaluire extends PlaceDetailsState {
  final String errMessage;

  PlaceDetailsCubitFaluire({required this.errMessage});
}

final class PlaceDetailsCubitLocationDestnationSelected
    extends PlaceDetailsState {}

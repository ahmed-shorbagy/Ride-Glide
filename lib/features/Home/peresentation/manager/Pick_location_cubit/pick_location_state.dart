part of 'pick_location_cubit.dart';

@immutable
sealed class PickLocationState {}

final class PickLocationInitial extends PickLocationState {}

final class PickLocationLoading extends PickLocationState {}

final class PickLocationSucceess extends PickLocationState {
  final PlaceDetailsModel placeDetails;

  PickLocationSucceess({required this.placeDetails});
}

final class PickLocationFaluire extends PickLocationState {
  final String errmessage;

  PickLocationFaluire({required this.errmessage});
}

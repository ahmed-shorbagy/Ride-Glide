part of 'pick_destination_cubit.dart';

@immutable
sealed class PickDestinationState {}

final class PickDestinationInitial extends PickDestinationState {}

final class PickDestinationLoading extends PickDestinationState {}

final class PickDestinationSuccess extends PickDestinationState {
  final PlaceDetailsModel placeDetails;

  PickDestinationSuccess({required this.placeDetails});
}

final class PickDestinationFaluire extends PickDestinationState {
  final String errMessage;

  PickDestinationFaluire({required this.errMessage});
}

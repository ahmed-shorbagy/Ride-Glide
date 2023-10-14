part of 'ride_requests_cubit.dart';

@immutable
sealed class RideRequestsState {}

final class RideRequestsInitial extends RideRequestsState {}

final class RideRequestsLoading extends RideRequestsState {}

final class RideRequestsSuccess extends RideRequestsState {}

final class RideRequestsFaluire extends RideRequestsState {
  final String errMessage;

  RideRequestsFaluire({required this.errMessage});
}

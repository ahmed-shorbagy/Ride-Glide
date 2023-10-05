part of 'online_drivers_cubit.dart';

@immutable
sealed class OnlineDriversState {}

final class OnlineDriversInitial extends OnlineDriversState {}

final class OnlineDriversLoading extends OnlineDriversState {}

final class OnlineDriversSuccess extends OnlineDriversState {
  final List<DriverModel> onlineDrivers;

  OnlineDriversSuccess({required this.onlineDrivers});
}

final class OnlineDriversFaluire extends OnlineDriversState {
  final String erMessage;

  OnlineDriversFaluire({required this.erMessage});
}

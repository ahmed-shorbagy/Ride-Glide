part of 'log_out_cubit.dart';

@immutable
sealed class LogOutState {}

final class LogOutInitial extends LogOutState {}

final class LogOutSuccess extends LogOutState {}

final class LogOutFaluire extends LogOutState {
  final String errMessage;

  LogOutFaluire({required this.errMessage});
}

final class LogOutLoading extends LogOutState {}

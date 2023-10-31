part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {}

final class ChangePasswordFaluire extends ChangePasswordState {
  final String errMessage;

  ChangePasswordFaluire({required this.errMessage});
}

final class ChangePasswordLoading extends ChangePasswordState {}

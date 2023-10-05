part of 'phone_auth_cubit.dart';

@immutable
sealed class PhoneAuthState {}

final class PhoneAuthInitial extends PhoneAuthState {}

final class PhoneAuthLoading extends PhoneAuthState {}

final class PhoneAuthSuccess extends PhoneAuthState {}

final class PhoneAuthFaluire extends PhoneAuthState {
  final String errMessage;
  PhoneAuthFaluire({required this.errMessage});
}

part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentSuccess extends PaymentState {}

final class PaymentFaluire extends PaymentState {
  final String errMessage;

  PaymentFaluire({required this.errMessage});
}

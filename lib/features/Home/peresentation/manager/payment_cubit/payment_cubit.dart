import 'package:bloc/bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.homeRepo) : super(PaymentInitial());
  final HomeRepo homeRepo;

  Future<void> makePayment(
      {required int amount, required String currency}) async {
    emit(
        PaymentLoading()); // Emit a loading state when the payment process starts.

    try {
      var clientSecret = await homeRepo.getClientSecret(
          amount: (amount * 100), currency: currency);
      clientSecret.fold((failure) {
        emit(PaymentFaluire(errMessage: failure.errMessage));
      }, (secret) async {
        emit(PaymentLoading()); //
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: secret, merchantDisplayName: 'Ahmed'),
        );
        emit(PaymentLoading()); //
        await Stripe.instance.presentPaymentSheet();
        emit(PaymentSuccess());
      });
    } catch (e) {
      emit(PaymentFaluire(errMessage: e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.homeRepo) : super(PaymentInitial());
  final HomeRepo homeRepo;
  Future<void> makePayment(
      {required int amount, required String currency}) async {
    emit(PaymentLoading());
    var payment =
        await homeRepo.makePayment(amount: amount, currency: currency);
    payment.fold((faluire) {
      emit(PaymentFaluire(errMessage: faluire.errMessage));
    }, (payment) {
      emit(PaymentSuccess());
    });
  }
}

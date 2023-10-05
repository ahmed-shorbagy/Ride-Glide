import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final AuthRepo authRepo;
  PhoneAuthCubit(this.authRepo) : super(PhoneAuthInitial());
  Future<void> initializephoneSignUp({required String phoneNumber}) async {
    emit(PhoneAuthLoading());
    var initalize = await authRepo.phoneAuth(phoneNumber);
    initalize.fold((faluire) {
      emit(PhoneAuthFaluire(errMessage: faluire.errMessage));
    }, (success) {});
  }

  Future<void> verifyOTP(String oTP) async {
    emit(PhoneAuthLoading());
    var verify = await authRepo.verifyOtp(oTP);
    verify.fold((faluire) {
      emit(PhoneAuthFaluire(errMessage: faluire.errMessage));
    }, (success) {
      if (success) {
        emit(PhoneAuthSuccess());
      } else {
        emit(PhoneAuthFaluire(errMessage: "Invalid OTP, please try again."));
      }
    });
  }
}

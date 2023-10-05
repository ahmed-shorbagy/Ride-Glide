import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';

part 'google_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final AuthRepo authRepo;
  GoogleAuthCubit(this.authRepo) : super(GoogleAuthInitial());

  Future<void> signUpWihGoogle() async {
    emit(GoogleAuthLoading());

    final userCredential = await authRepo.signInWithGoogle();
    userCredential.fold((faluire) {
      emit(GoogleAuthFaluire(errMessage: faluire.errMessage));
    }, (success) {
      emit(GoogleAuthSuccess());
    });
  }
}

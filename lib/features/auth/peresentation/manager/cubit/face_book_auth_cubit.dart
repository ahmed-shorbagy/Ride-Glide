import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';

part 'face_book_auth_state.dart';

class FaceBookAuthCubit extends Cubit<FaceBookAuthState> {
  final AuthRepo authRepo;
  FaceBookAuthCubit(this.authRepo) : super(FaceBookAuthInitial());

  Future<void> signUpWithFaceBook() async {
    emit(FaceBookAuthLoading());
    var signIn = await authRepo.signInWithFacebook();
    signIn.fold((faluire) {
      emit(FaceBookAuthFaluire(errMessage: faluire.errMessage));
    }, (success) {
      emit(FaceBookAuthSuccess());
    });
  }
}

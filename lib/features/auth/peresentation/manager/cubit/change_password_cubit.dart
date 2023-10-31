import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
  Future<void> updatePassword({required newPassword}) async {
    try {
      emit(ChangePasswordLoading());
      await auth.currentUser?.updatePassword(newPassword);
      emit(ChangePasswordSuccess());
    } catch (e) {
      emit(ChangePasswordFaluire(errMessage: e.toString()));
    }
  }
}

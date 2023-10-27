import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());
  Future<void> logOut() async {
    emit(LogOutLoading());
    try {
      await auth.signOut();
      emit(LogOutSuccess());
    } catch (e) {
      emit(LogOutFaluire(errMessage: e.toString()));
    }
  }
}

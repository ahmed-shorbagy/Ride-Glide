import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';

part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit(this.authRepo) : super(GetUserDataInitial());

  final AuthRepo authRepo;
  Future<void> getUserData({required String uId}) async {
    emit(GetUserDataLoading());

    var responce = await authRepo.getUserData(uid: uId);
    responce.fold((faluire) {
      emit(GetUserDataFaluire(errMessage: faluire.errMessage));
    }, (user) {
      emit(GetUserDataSuccess(user: user));
    });
  }
}

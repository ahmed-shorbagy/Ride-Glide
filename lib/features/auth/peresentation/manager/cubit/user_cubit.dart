import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  static UserModel user = UserModel(phone: '');
  UserCubit() : super(UserInitial());
}

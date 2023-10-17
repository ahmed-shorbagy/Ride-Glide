part of 'get_user_data_cubit.dart';

@immutable
sealed class GetUserDataState {}

final class GetUserDataInitial extends GetUserDataState {}

final class GetUserDataLoading extends GetUserDataState {}

final class GetUserDataSuccess extends GetUserDataState {
  final UserModel user;

  GetUserDataSuccess({required this.user});
}

final class GetUserDataFaluire extends GetUserDataState {
  final String errMessage;

  GetUserDataFaluire({required this.errMessage});
}

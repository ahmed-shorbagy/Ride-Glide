part of 'delete_password_cubit.dart';

@immutable
sealed class DeletePasswordState {}

final class DeletePasswordInitial extends DeletePasswordState {}

final class DeletePasswordLoading extends DeletePasswordState {}

final class DeletePasswordFaluire extends DeletePasswordState {
  final String errMessage;

  DeletePasswordFaluire({required this.errMessage});
}

final class DeletePasswordSuccess extends DeletePasswordState {}

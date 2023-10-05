part of 'face_book_auth_cubit.dart';

@immutable
sealed class FaceBookAuthState {}

final class FaceBookAuthInitial extends FaceBookAuthState {}

final class FaceBookAuthLoading extends FaceBookAuthState {}

final class FaceBookAuthSuccess extends FaceBookAuthState {}

final class FaceBookAuthFaluire extends FaceBookAuthState {
  final String errMessage;
  FaceBookAuthFaluire({required this.errMessage});
}

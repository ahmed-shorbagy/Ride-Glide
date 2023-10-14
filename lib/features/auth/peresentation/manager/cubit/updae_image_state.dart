part of 'updae_image_cubit.dart';

@immutable
sealed class UpdaeImageState {}

final class UpdaeImageInitial extends UpdaeImageState {}

final class UpdaeImageLoading extends UpdaeImageState {}

final class UpdateImageSuccess extends UpdaeImageState {
  final String imageUrl;

  UpdateImageSuccess({required this.imageUrl});
}

final class UpdaeImageFaluire extends UpdaeImageState {
  final String erMessage;

  UpdaeImageFaluire({required this.erMessage});
}

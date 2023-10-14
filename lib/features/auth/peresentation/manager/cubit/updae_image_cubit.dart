import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';

part 'updae_image_state.dart';

class UpdaeImageCubit extends Cubit<UpdaeImageState> {
  UpdaeImageCubit(this.authRepo) : super(UpdaeImageInitial());
  final AuthRepo authRepo;
  Future<void> uploadDriverImageToFirebase({required String imagePath}) async {
    emit(UpdaeImageLoading());
    var responce = await authRepo.uploadUserPhoto(imagePath);
    responce.fold((faluire) {
      emit(UpdaeImageFaluire(erMessage: faluire.errMessage));
    }, (url) {
      emit(UpdateImageSuccess(imageUrl: url));
    });
  }
}

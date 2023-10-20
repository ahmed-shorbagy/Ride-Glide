import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';

part 'email_paswword_state.dart';

class EmailPaswwordCubit extends Cubit<EmailPaswwordState> {
  final AuthRepo authRepo;
  EmailPaswwordCubit(this.authRepo) : super(EmailPaswwordInitial());
  Future<void> signupUser(
      {required String email, required String password}) async {
    emit(EmailPaswwordLoadin());

    final userCredential = await authRepo.signUpWIthEmailAndPassword(
        email: email, password: password);
    userCredential.fold((faluire) {
      emit(EmailPaswwordFaluire(errMessage: faluire.errMessage));
    }, (success) {
      emit(EmailPaswwordSuccess());
    });
  }

  Future<void> signInUser(
      {required String email, required String password}) async {
    emit(EmailPaswwordLoadin());

    final userCredential = await authRepo.signInWIthEmailAndPassword(
        email: email, password: password);
    userCredential.fold((faluire) {
      emit(EmailPaswwordFaluire(errMessage: faluire.errMessage));
    }, (success) {
      emit(EmailPaswwordSuccess());
    });
  }

  Future<void> addUserToFireStore(
      {required UserModel user, required String uid}) async {
    final responce = await authRepo.addNewUserToFireStore(user: user, uid: uid);
    responce.fold((faluire) {
      emit(EmailPaswwordFaluire(errMessage: faluire.errMessage));
    }, (success) {});
  }
}

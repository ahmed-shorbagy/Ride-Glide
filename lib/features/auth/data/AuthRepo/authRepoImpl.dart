import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ride_glide/core/errors/Faluire_model.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class AuthRepo {
  String verificationId = '';
  static final firestore = FirebaseFirestore.instance;
  get context => null;

  Future<Either<Faluire, UserCredential?>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return left(FirbaseFaluire.fromFirebaseAuth('Google sign in failed'));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return right(
          await FirebaseAuth.instance.signInWithCredential(credential));
    } catch (e) {
      return left(FirbaseFaluire.fromFirebaseAuth(e.toString()));
    }
  }

  Future<Either<Faluire, UserCredential?>> signInWithFacebook() async {
    // Trigger the sign-in flow
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.cancelled ||
          loginResult.status == LoginStatus.failed) {
        // User canceled the Facebook sign-in
        return left(FirbaseFaluire.fromFirebaseAuth('face sign in failed'));
      }
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken?.token ?? '');

      // Once signed in, return the UserCredential
      return right(await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential));
    } catch (e) {
      return left(FirbaseFaluire.fromFirebaseAuth(e.toString()));
    }
  }

  Future<Either<Faluire, void>> phoneAuth(String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      return left(FirbaseFaluire.fromFirebaseAuth(e.toString()));
    }
    return right(null);
  }

  Future<Either<Faluire, bool>> verifyOtp(String otp) async {
    try {
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otp));
      return right(credential.user != null ? true : false);
    } catch (e) {
      return left(FirbaseFaluire.fromFirebaseAuth(e.toString()));
    }
  }

  Future<Either<Faluire, UserCredential?>> signUpWIthEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(credential);
    } catch (e) {
      debugPrint(' the exception ISSSSSSS =  ${e.toString()}');

      return left(FirbaseFaluire.fromFirebaseAuth(e.toString()));
    }
  }

  Future<Either<Faluire, UserCredential?>> signInWIthEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(credential);
    } catch (e) {
      debugPrint('the exception ISSSSSSS== ${e.toString()}');
      return left(FirbaseFaluire.fromFirebaseAuth(e.toString()));
    }
  }

  Future<bool> verifyEmail({required String email}) async {
    try {
      final signInMethods = await auth.fetchSignInMethodsForEmail(
        email,
      );
      if (signInMethods.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Either<Faluire, void>> updateUserPassword(
      {required String email}) async {
    try {
      final credential = await auth.sendPasswordResetEmail(email: email);
      return right(credential);
    } catch (e) {
      debugPrint('the exception ISSSSSSS== ${e.toString()}');
      return left(FirbaseFaluire.fromFirebaseAuth(e.toString()));
    }
  }

  Future<Either<Faluire, String>> uploadUserPhoto(String imagePath) async {
    try {
      final storage = FirebaseStorage.instance;
      final storageRef =
          storage.ref().child('User_photos/${auth.currentUser?.uid}.jpg');
      final uploadTask = storageRef.putFile(File(imagePath));

      // Wait for the upload to complete and get the download URL
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadURL = await snapshot.ref.getDownloadURL();

      return right(downloadURL);
    } catch (e) {
      // Handle upload errors
      debugPrint('Error uploading driver photo: $e');
      return left(FirbaseFaluire.fromFirebaseAuth(e.toString()));
    }
  }

  Future<Either<Faluire, void>> addNewUserToFireStore(
      {required UserModel user, required String uid}) async {
    try {
      final driverRef = firestore.collection('Users').doc(uid);
      await driverRef.set(user.toMap());
      return right(null);
    } catch (e) {
      return left(FirbaseFaluire.fromFirebaseAuth(e.toString()));
    }
  }

  Future<Either<Faluire, UserModel>> getUserData({required String uid}) async {
    try {
      final userDocument =
          FirebaseFirestore.instance.collection('Users').doc(uid);

      final query = await userDocument.get();

      if (query.exists) {
        final userData = query.data() as Map<String, dynamic>;
        final user = UserModel.fromFireStore(userData);
        return Right(user);
      } else {
        return Left(FirbaseFaluire.fromFirebaseAuth('User not found'));
      }
    } catch (e) {
      return Left(FirbaseFaluire.fromFirebaseAuth(e.toString()));
    }
  }
}

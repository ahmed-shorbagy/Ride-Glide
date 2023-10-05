import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ride_glide/core/errors/Faluire_model.dart';

class AuthRepo {
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationId = '';
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
}

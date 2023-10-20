import 'package:dio/dio.dart';

abstract class Faluire {
  final String errMessage;

  Faluire({required this.errMessage});
}

class FirbaseFaluire extends Faluire {
  FirbaseFaluire({required super.errMessage});
  factory FirbaseFaluire.fromFirebaseAuth(String authException) {
    switch (authException) {
      case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return FirbaseFaluire(errMessage: 'account already exists');
      case 'auth/email-already-exists':
        return FirbaseFaluire(errMessage: 'account already exists');
      case 'auth/id-token-expired':
        return FirbaseFaluire(errMessage: 'the ocde expired please try again');
      case 'auth/phone-number-already-exists':
        return FirbaseFaluire(errMessage: 'the phone number already exists');
      case 'auth/session-cookie-expired':
        return FirbaseFaluire(errMessage: 'session expired please try again');
      case 'auth/too-many-requests':
        return FirbaseFaluire(
            errMessage: 'too many requests please try again later');
      case 'auth/user-not-found':
        return FirbaseFaluire(errMessage: 'no account found please sign up ');
      case 'firebase_auth/invalid-verification-code':
        return FirbaseFaluire(errMessage: 'invalid code please try again');
      case '[firebase_auth/invalid-verification-code] The verification code from SMS/TOTP is invalid. Please check and enter the correct verification code again.':
        return FirbaseFaluire(errMessage: 'invalid code please try again');
      case '[firebase_auth/session-expired] The sms code has expired. Please re-send the verification code to try again.':
        return FirbaseFaluire(
            errMessage: 'session-expired press re-send to try again');
      case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
        return FirbaseFaluire(
            errMessage: 'The account already exists for that email.');
      case 'user-not-found':
        return FirbaseFaluire(errMessage: 'No user found for that email.');
      case 'User not found':
        return FirbaseFaluire(errMessage: 'User not found');
      case '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.':
        return FirbaseFaluire(
            errMessage: 'Wrong password provided for that user.');

      case '[firebase_auth/invalid-email] The email address is badly formatted.':
        return FirbaseFaluire(
            errMessage: 'invalid email format please try again');
      case 'network-request-failed':
        return FirbaseFaluire(
            errMessage: 'networkRequest error please check your connection');
      case '[firebase_auth/weak-password] Password should be at least 6 characters':
        return FirbaseFaluire(
            errMessage: 'Password should be at least 6 characters');

      default:
        return FirbaseFaluire(
            errMessage: 'Oops there was an error, please try again later!');
    }
  }
}

class ServerFaliure extends Faluire {
  ServerFaliure({required super.errMessage});
  factory ServerFaliure.fromDioErr(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFaliure(errMessage: 'Connection time out with the server');
      case DioExceptionType.cancel:
        return ServerFaliure(errMessage: 'Request to server was cancled');
      case DioExceptionType.connectionError:
        return ServerFaliure(errMessage: 'Connection time out with the server');
      case DioExceptionType.sendTimeout:
        return ServerFaliure(
            errMessage:
                'send time out with the server, please try again later!');
      case DioExceptionType.receiveTimeout:
        return ServerFaliure(
            errMessage:
                'recieve time out with the server, please try again later!');
      case DioExceptionType.badResponse:
        return ServerFaliure.fromResponce(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFaliure(errMessage: 'No Internet Connection');
        }
        return ServerFaliure(
            errMessage: 'Un Expected Error please try again later');
      default:
        return ServerFaliure(
            errMessage: 'Oops there was an error, please try again later!');
    }
  }
  factory ServerFaliure.fromResponce(int statusCode, dynamic responce) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFaliure(errMessage: responce['error']['message']);
    } else if (statusCode == 404) {
      return ServerFaliure(
          errMessage: 'Your request not found, please try again later!');
    } else if (statusCode == 500) {
      return ServerFaliure(
          errMessage: 'Internal server proplem, please try again later!');
    } else {
      return ServerFaliure(
          errMessage: 'Oops there was an error, please try again later!');
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';
import 'package:ride_glide/features/Home/peresentation/views/Choose_destination_onMap_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/SelectTransport_View.dart';
import 'package:ride_glide/features/Home/peresentation/views/avaialbe_cars_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/choose_Location_onMap_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/confirm_booking_view.dart';
import 'package:ride_glide/features/auth/peresentation/views/OTP_view.dart';
import 'package:ride_glide/features/auth/peresentation/views/setProfile_view.dart';
import 'package:ride_glide/features/auth/peresentation/views/set_password_view.dart';
import 'package:ride_glide/features/auth/peresentation/views/signInView.dart';
import 'package:ride_glide/features/auth/peresentation/views/sign_up_view.dart';
import 'package:ride_glide/features/auth/peresentation/views/verify_email_view.dart';
import 'package:ride_glide/features/auth/peresentation/views/welcome_view.dart';

import '../../features/Home/peresentation/views/home_view.dart';
import '../../features/splash&OnBoarding/on_boarding_view.dart';
import '../../features/splash&OnBoarding/peresentation/views/splash_view.dart';

abstract class AppRouter {
  static const String kHomeView = '/HomeView';
  static const String kOnBoardingView = '/OnBoardingView';
  static const String kAuthWelcomeView = '/AuthWelcomeView';
  static const String kSignUpView = '/SignUpView';
  static const String kOTPView = '/OTPView';
  static const String kSetPaswwordView = '/SetPaswwordView';
  static const String kSetProfileView = '/SetProfileView';
  static const String kSignInView = '/SignInView';
  static const String kverifyEmailView = '/verifyEmailView';
  static const String kSelectTransportView = '/SelectTransportView';
  static const String kAvaialbeCarsView = '/AvaialbeCarsView';
  static const String kChooseLocationOnMapView = '/ChooseLocationOnMapView';
  static const String kChooseDestinationOnMapView =
      '/ChooseDestinationOnMapView';
  static const String kConfirmBookingView = '/ConfirmBookingView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashVIew(),
      ),
      GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) {
          return transition(
            child: const HomeView(),
          );
        },
      ),
      GoRoute(
        path: kOnBoardingView,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: kAuthWelcomeView,
        pageBuilder: (context, state) {
          return transition(child: const WelcomeView());
        },
      ),
      GoRoute(
        path: kSignUpView,
        pageBuilder: (context, state) {
          return transition(child: const SignUpView());
        },
      ),
      GoRoute(
        path: kOTPView,
        pageBuilder: (context, state) {
          return transition(child: const OTPView());
        },
      ),
      GoRoute(
        path: kSetPaswwordView,
        pageBuilder: (context, state) {
          return transition(child: const SetPasswordView());
        },
      ),
      GoRoute(
        path: kSetProfileView,
        pageBuilder: (context, state) {
          return transition(child: const SetProfileView());
        },
      ),
      GoRoute(
        path: kSignInView,
        pageBuilder: (context, state) {
          return transition(child: const SignInView());
        },
      ),
      GoRoute(
        path: kverifyEmailView,
        pageBuilder: (context, state) {
          return transition(child: const VerifyEmailView());
        },
      ),
      GoRoute(
        path: kSelectTransportView,
        pageBuilder: (context, state) {
          return transition(child: const SelectTransportView());
        },
      ),
      GoRoute(
        path: kAvaialbeCarsView,
        pageBuilder: (context, state) {
          return transition(child: const AvaialbeCarsView());
        },
      ),
      GoRoute(
        path: kChooseLocationOnMapView,
        pageBuilder: (context, state) {
          return transition(child: const ChooseLocationOnMapView());
        },
      ),
      GoRoute(
        path: kChooseDestinationOnMapView,
        pageBuilder: (context, state) {
          return transition(child: const ChooseDestinationOnMapView());
        },
      ),
      GoRoute(
        path: kConfirmBookingView,
        pageBuilder: (context, state) {
          return transition(
              child: COnfirmBookingView(
            driver: state.extra as DriverModel,
          ));
        },
      ),
    ],
  );
}

CustomTransitionPage transition({required child}) {
  return CustomTransitionPage(
    transitionDuration: const Duration(milliseconds: 400),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}

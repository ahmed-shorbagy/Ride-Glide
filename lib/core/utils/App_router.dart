import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';
import 'package:ride_glide/features/Home/peresentation/views/ChangePasswordView.dart';
import 'package:ride_glide/features/Home/peresentation/views/Choose_destination_onMap_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/Delete_account_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/Privacy_polic_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/Profile_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/SelectTransport_View.dart';
import 'package:ride_glide/features/Home/peresentation/views/avaialbe_cars_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/change_language_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/change_theme_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/choose_Location_onMap_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/confirm_booking_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/payment_success_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/settings_view.dart';
import 'package:ride_glide/features/auth/peresentation/views/OTP_view.dart';
import 'package:ride_glide/features/auth/peresentation/views/otp_view_forOtherSignUpOptions.dart';
import 'package:ride_glide/features/auth/peresentation/views/setProfile_view.dart';
import 'package:ride_glide/features/auth/peresentation/views/set_password_view.dart';
import 'package:ride_glide/features/auth/peresentation/views/set_phoneNumber_view.dart';
import 'package:ride_glide/features/auth/peresentation/views/set_profile_view_for_other_signUpOptions.dart';
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
  static const String kOTPViewForOtherSignUpOptions =
      '/OTPViewForOtherSignUpOptions';
  static const String kSetPaswwordView = '/SetPaswwordView';
  static const String kSetProfileView = '/SetProfileView';
  static const String kSetProfileViewForOtherSignUpOptions =
      '/SetProfileViewForOtherSignUpOptions';
  static const String kSetPhoneNumberView = '/SetPhoneNumberView';
  static const String kSignInView = '/SignInView';
  static const String kverifyEmailView = '/verifyEmailView';
  static const String kSelectTransportView = '/SelectTransportView';
  static const String kAvaialbeCarsView = '/AvaialbeCarsView';
  static const String kChooseLocationOnMapView = '/ChooseLocationOnMapView';
  static const String kChooseDestinationOnMapView =
      '/ChooseDestinationOnMapView';
  static const String kConfirmBookingView = '/ConfirmBookingView';
  static const String kPaymentSuccessView = '/PaymentSuccessView';
  static const String kProfileView = '/ProfileView';
  static const String kSettingsView = '/SettingsView';
  static const String kChangePasswordView = '/ChangePasswordView';
  static const String kChangeLanguageView = '/ChangeLanguageView';
  static const String kPrivacyPolicyView = '/PrivacyPolicyView';
  static const String kChangeThemeView = '/ChangeThemeView';
  static const String kDeleteAccountView = '/DeleteAccountView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashVIew(),
      ),
      GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) {
          return basicTransition(
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
          return basicTransition(child: const WelcomeView());
        },
      ),
      GoRoute(
        path: kSignUpView,
        pageBuilder: (context, state) {
          return basicTransition(child: const SignUpView());
        },
      ),
      GoRoute(
        path: kSetProfileViewForOtherSignUpOptions,
        pageBuilder: (context, state) {
          return basicTransition(
              child: const SetProfileViewForOtherSignUpOptions());
        },
      ),
      GoRoute(
        path: kChangePasswordView,
        pageBuilder: (context, state) {
          return basicTransition(child: const ChangePasswordView());
        },
      ),
      GoRoute(
        path: kChangeLanguageView,
        pageBuilder: (context, state) {
          return basicTransition(child: const ChangeLanguageView());
        },
      ),
      GoRoute(
        path: kPrivacyPolicyView,
        pageBuilder: (context, state) {
          return basicTransition(child: const PrivacyPolicyView());
        },
      ),
      GoRoute(
        path: kChangeThemeView,
        pageBuilder: (context, state) {
          return basicTransition(child: const ChangeThemeView());
        },
      ),
      GoRoute(
        path: kDeleteAccountView,
        pageBuilder: (context, state) {
          return basicTransition(child: const DeleteAccountView());
        },
      ),
      GoRoute(
        path: kOTPView,
        pageBuilder: (context, state) {
          return basicTransition(child: const OTPView());
        },
      ),
      GoRoute(
        path: kSetPaswwordView,
        pageBuilder: (context, state) {
          return basicTransition(child: const SetPasswordView());
        },
      ),
      GoRoute(
        path: kSetProfileView,
        pageBuilder: (context, state) {
          return basicTransition(child: const SetProfileView());
        },
      ),
      GoRoute(
        path: kSettingsView,
        pageBuilder: (context, state) {
          return basicTransition(child: const SettingsView());
        },
      ),
      GoRoute(
        path: kSignInView,
        pageBuilder: (context, state) {
          return basicTransition(child: const SignInView());
        },
      ),
      GoRoute(
        path: kverifyEmailView,
        pageBuilder: (context, state) {
          return basicTransition(child: const VerifyEmailView());
        },
      ),
      GoRoute(
        path: kSelectTransportView,
        pageBuilder: (context, state) {
          return basicTransition(child: const SelectTransportView());
        },
      ),
      GoRoute(
        path: kAvaialbeCarsView,
        pageBuilder: (context, state) {
          return basicTransition(child: const AvaialbeCarsView());
        },
      ),
      GoRoute(
        path: kChooseLocationOnMapView,
        pageBuilder: (context, state) {
          return basicTransition(child: const ChooseLocationOnMapView());
        },
      ),
      GoRoute(
        path: kOTPViewForOtherSignUpOptions,
        pageBuilder: (context, state) {
          return basicTransition(child: const OTPViewForOtherSignUpOptions());
        },
      ),
      GoRoute(
        path: kChooseDestinationOnMapView,
        pageBuilder: (context, state) {
          return basicTransition(child: const ChooseDestinationOnMapView());
        },
      ),
      GoRoute(
        path: kSetPhoneNumberView,
        pageBuilder: (context, state) {
          return basicTransition(child: const SetPhoneNumberView());
        },
      ),
      GoRoute(
        path: kProfileView,
        pageBuilder: (context, state) {
          return stylishSideTransition(
            child: const ProfileView(),
          );
        },
      ),
      GoRoute(
        path: kPaymentSuccessView,
        pageBuilder: (context, state) {
          return basicTransition(
              child: PaymentSuccessView(
            driver: state.extra as DriverModel,
          ));
        },
      ),
      GoRoute(
        path: kConfirmBookingView,
        pageBuilder: (context, state) {
          return basicTransition(
              child: COnfirmBookingView(
            driver: state.extra as DriverModel,
          ));
        },
      ),
    ],
  );
}

CustomTransitionPage basicTransition({required child}) {
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

CustomTransitionPage stylishSideTransition({required child}) {
  return CustomTransitionPage(
    transitionDuration: const Duration(milliseconds: 400),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .animate(animation),
        child: child,
      );
    },
  );
}

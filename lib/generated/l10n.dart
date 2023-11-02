// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get bottomBarHome {
    return Intl.message(
      'Home',
      name: 'bottomBarHome',
      desc: '',
      args: [],
    );
  }

  /// `Favourite`
  String get bottomBarFavourite {
    return Intl.message(
      'Favourite',
      name: 'bottomBarFavourite',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get bottomBarWallet {
    return Intl.message(
      'Wallet',
      name: 'bottomBarWallet',
      desc: '',
      args: [],
    );
  }

  /// `Offer`
  String get bottomBarOffer {
    return Intl.message(
      'Offer',
      name: 'bottomBarOffer',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get bottomBarProifle {
    return Intl.message(
      'Profile',
      name: 'bottomBarProifle',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Destination`
  String get Destination {
    return Intl.message(
      'Destination',
      name: 'Destination',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get Back {
    return Intl.message(
      'Back',
      name: 'Back',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get History {
    return Intl.message(
      'History',
      name: 'History',
      desc: '',
      args: [],
    );
  }

  /// `Complain`
  String get Complain {
    return Intl.message(
      'Complain',
      name: 'Complain',
      desc: '',
      args: [],
    );
  }

  /// `Referral`
  String get Referral {
    return Intl.message(
      'Referral',
      name: 'Referral',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get AboutUs {
    return Intl.message(
      'About Us',
      name: 'AboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get LogOut {
    return Intl.message(
      'Log Out',
      name: 'LogOut',
      desc: '',
      args: [],
    );
  }

  /// `Help and Support`
  String get HelpandSupport {
    return Intl.message(
      'Help and Support',
      name: 'HelpandSupport',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get ChangePassword {
    return Intl.message(
      'Change Password',
      name: 'ChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get ChangeLanguage {
    return Intl.message(
      'Change Language',
      name: 'ChangeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get PrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'PrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Change Theme`
  String get ChangeTheme {
    return Intl.message(
      'Change Theme',
      name: 'ChangeTheme',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get DeleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'DeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `SelectAddress`
  String get SelectAddress {
    return Intl.message(
      'SelectAddress',
      name: 'SelectAddress',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get From {
    return Intl.message(
      'From',
      name: 'From',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get To {
    return Intl.message(
      'To',
      name: 'To',
      desc: '',
      args: [],
    );
  }

  /// `Choose On Map`
  String get ChooseOnMap {
    return Intl.message(
      'Choose On Map',
      name: 'ChooseOnMap',
      desc: '',
      args: [],
    );
  }

  /// `Order Now`
  String get OrderNow {
    return Intl.message(
      'Order Now',
      name: 'OrderNow',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get Done {
    return Intl.message(
      'Done',
      name: 'Done',
      desc: '',
      args: [],
    );
  }

  /// `Just Tap On your Desired Location !`
  String get JustTapOnyourDesiredLocation {
    return Intl.message(
      'Just Tap On your Desired Location !',
      name: 'JustTapOnyourDesiredLocation',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Transport`
  String get SelectYourTransport {
    return Intl.message(
      'Select Your Transport',
      name: 'SelectYourTransport',
      desc: '',
      args: [],
    );
  }

  /// `Bike`
  String get Bike {
    return Intl.message(
      'Bike',
      name: 'Bike',
      desc: '',
      args: [],
    );
  }

  /// `Car`
  String get Car {
    return Intl.message(
      'Car',
      name: 'Car',
      desc: '',
      args: [],
    );
  }

  /// `Taxi`
  String get Taxi {
    return Intl.message(
      'Taxi',
      name: 'Taxi',
      desc: '',
      args: [],
    );
  }

  /// `Cycle`
  String get Cycle {
    return Intl.message(
      'Cycle',
      name: 'Cycle',
      desc: '',
      args: [],
    );
  }

  /// `Available Cars For Ride`
  String get AvailableCarsForRide {
    return Intl.message(
      'Available Cars For Ride',
      name: 'AvailableCarsForRide',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Set Password`
  String get SetPassword {
    return Intl.message(
      'Set Password',
      name: 'SetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get Delete {
    return Intl.message(
      'Delete',
      name: 'Delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? Please read how account deletion will affect.Deleting your account removes personal information our database. Tour email becomes permanently reserved and same email cannot be re-use to register a new account.`
  String get AreYouSure {
    return Intl.message(
      'Are you sure you want to delete your account? Please read how account deletion will affect.Deleting your account removes personal information our database. Tour email becomes permanently reserved and same email cannot be re-use to register a new account.',
      name: 'AreYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get SaveChanges {
    return Intl.message(
      'Save Changes',
      name: 'SaveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get EnterYourPassword {
    return Intl.message(
      'Enter your password',
      name: 'EnterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get ConfirmPassword {
    return Intl.message(
      'Confirm your password',
      name: 'ConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords Dont Match`
  String get PasswordDontMatch {
    return Intl.message(
      'Passwords Dont Match',
      name: 'PasswordDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password Changed Successfully`
  String get PasswordChangedSuccessfully {
    return Intl.message(
      'Password Changed Successfully',
      name: 'PasswordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

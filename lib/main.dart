import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:ride_glide/constants.dart';
import 'package:ride_glide/core/errors/simple_bloc_observer.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/core/utils/service_locator.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo_implementation.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Language_cubit/language_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/OnlineDrivers_cubit/online_drivers_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_destination_cubit/pick_destination_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_location_cubit/pick_location_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Place_AutoComplete_cubit/place_auto_complete_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Place_details_cubit/place_details_cubit_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Ride_requests_cubit/ride_requests_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Theme_provider/Theme_provider.dart';
import 'package:ride_glide/features/Home/peresentation/manager/payment_cubit/payment_cubit.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/change_password_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/email_paswword_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/face_book_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/get_userData_cubit/delete_password_cubit/delete_password_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/get_userData_cubit/get_user_data_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/google_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/log_out_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/phone_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/updae_image_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/user_cubit.dart';
import 'package:ride_glide/firebase_options.dart';
import 'package:ride_glide/generated/l10n.dart';

import 'core/utils/App_router.dart';
import 'core/utils/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loadMapStyles();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>(kUserBox);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupServiceLocator();
  runApp(ChangeNotifierProvider(
    create: (_) {
      return ThemeProvider();
    },
    child: const RideGlide(),
  ));
  Bloc.observer = SimpleBLocObserver();
  Stripe.publishableKey = HomeRepoImpl.stripePublishablekey;
  Stripe.instance.applySettings();
}

class RideGlide extends StatelessWidget {
  const RideGlide({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GoogleAuthCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => ChangePasswordCubit(),
        ),
        BlocProvider(
          create: (context) => DeletePasswordCubit(),
        ),
        BlocProvider(
          create: (context) => LogOutCubit(),
        ),
        BlocProvider(
          create: (context) => OnlineDriversCubit(getIt.get<HomeRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => PlaceDetailsCubit(getIt.get<HomeRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => PickLocationCubit(getIt.get<HomeRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => PickDestinationCubit(getIt.get<HomeRepoImpl>()),
        ),
        BlocProvider(
          create: (context) =>
              PlaceAutoCompleteCubit(getIt.get<HomeRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => PaymentCubit(getIt.get<HomeRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => RideRequestsCubit(getIt.get<HomeRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => FaceBookAuthCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => GetUserDataCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => PhoneAuthCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => UpdaeImageCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => EmailPaswwordCubit(AuthRepo()),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          if (state is LanguageSuccess) {
            return MaterialApp.router(
              locale: state.local,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
              theme: lightTheme(),
              darkTheme: darkTheme(),
              themeMode: themeProvider.themeMode,
            );
          } else {
            return MaterialApp.router(
                locale: const Locale('en'),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                routerConfig: AppRouter.router,
                debugShowCheckedModeBanner: false,
                theme: lightTheme(),
                darkTheme: darkTheme(),
                themeMode: themeProvider.themeMode);
          }
        },
      ),
    );
  }
}

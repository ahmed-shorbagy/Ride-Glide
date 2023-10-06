import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ride_glide/core/errors/simple_bloc_observer.dart';
import 'package:ride_glide/core/utils/service_locator.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo_implementation.dart';
import 'package:ride_glide/features/Home/peresentation/manager/OnlineDrivers_cubit/online_drivers_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_destination_cubit/pick_destination_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_location_cubit/pick_location_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Place_AutoComplete_cubit/place_auto_complete_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Place_details_cubit/place_details_cubit_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/payment_cubit/payment_cubit.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/email_paswword_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/face_book_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/google_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/phone_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/user_cubit.dart';
import 'package:ride_glide/firebase_options.dart';

import 'core/utils/App_router.dart';
import 'core/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupServiceLocator();
  runApp(const RideGlide());
  Bloc.observer = SimpleBLocObserver();
  Stripe.publishableKey = HomeRepoImpl.stripePublishablekey;
}

class RideGlide extends StatelessWidget {
  const RideGlide({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GoogleAuthCubit(AuthRepo()),
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
          create: (context) => FaceBookAuthCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => PhoneAuthCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => EmailPaswwordCubit(AuthRepo()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: theme(),
      ),
    );
  }
}

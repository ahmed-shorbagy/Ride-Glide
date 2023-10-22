import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:ride_glide/constants.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';

import '../../../../../core/utils/App_router.dart';
import 'sliding_text.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

late AnimationController animationController;
late Animation<Offset> animation;

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigatetoOnBoarding();
    _checkInternetAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'RideGlide',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).primaryColor),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 12,
        ),
        const SlidingText()
      ],
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween<Offset>(begin: const Offset(0, 6), end: Offset.zero)
        .animate(animationController);
    animationController.forward();
  }

  void navigatetoOnBoarding() async {
    bool isConnected = await checkInternetConnectivity();
    if (isConnected) {
      Future.delayed(const Duration(seconds: 3), () {
        var userBox = Hive.box<UserModel>(kUserBox);
        if (userBox.isEmpty) {
          GoRouter.of(context).pushReplacement(AppRouter.kOnBoardingView);
        } else {
          GoRouter.of(context).push(AppRouter.kHomeView);
        }
      });
    }
  }

  Future<void> _checkInternetAndNavigate() async {
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text('Please check your network connection.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Close App'),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          );
        },
      );
    }
  }
}

Future<bool> checkInternetConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}

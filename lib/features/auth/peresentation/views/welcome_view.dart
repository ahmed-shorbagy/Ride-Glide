import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(
          height: 100,
        ),
        SizedBox(
          child: Image.asset(Assets.Group39338),
        ),
        const SizedBox(
          height: 29,
        ),
        Text(
          'Welcome',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          'Have a better sharing experience',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
        ),
        const Spacer(
          flex: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
          child: CustomButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kSignUpView);
            },
            title: Text(
              'Create an account',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
          child: CustomButton(
            backgroundColor: Colors.white,
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kSignInView);
            },
            title: Text(
              'Log in',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).primaryColor, fontSize: 16),
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        )
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_divider.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/input_field_section._for_signUp.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/other_signUp_options_sectoin.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40, right: 25),
                  child: CustomAppBar(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    'Sign Up with your email or phone number',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                const InputFieldsSectionForSignUp(),
                const SizedBox(
                  height: 22,
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomDivider(),
                const OtherSignUpOptions(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kSignInView);
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: TextSpan(
                        text: 'Already have an account?',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                        children: [
                          TextSpan(
                              text: '  Sign in',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.7))),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

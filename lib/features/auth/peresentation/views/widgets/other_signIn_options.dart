import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/face_book_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/google_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custombutton_text_and_icon.dart';

class OtherSignInOptions extends StatelessWidget {
  const OtherSignInOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
            listener: (context, state) {
              if (state is GoogleAuthSuccess) {
                GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
              }
            },
            builder: (context, state) {
              return CustomButton(
                backgroundColor: Colors.white,
                onPressed: () async {
                  await BlocProvider.of<GoogleAuthCubit>(context)
                      .signUpWihGoogle();

                  if (state is GoogleAuthFaluire) {
                    snackBar(context, 'an error occurred please try again');
                  }
                },
                title: CustomButtonTextWithIcon(
                  text: 'Sign in with Gmail',
                  icon: state is GoogleAuthLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).hoverColor,
                          ),
                        )
                      : const Icon(
                          FontAwesomeIcons.envelope,
                          color: Colors.red,
                        ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: BlocConsumer<FaceBookAuthCubit, FaceBookAuthState>(
            listener: (context, state) {
              if (state is FaceBookAuthSuccess) {
                GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
              }
            },
            builder: (context, state) {
              return CustomButton(
                backgroundColor: Colors.white,
                onPressed: () async {
                  await BlocProvider.of<FaceBookAuthCubit>(context)
                      .signUpWithFaceBook();

                  if (state is FaceBookAuthFaluire) {
                    snackBar(context, 'an error occurred please try again');
                  }
                },
                title: CustomButtonTextWithIcon(
                  text: 'Sign in with Facebook',
                  icon: state is FaceBookAuthLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).hoverColor,
                          ),
                        )
                      : const Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                        ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CustomButton(
            backgroundColor: Colors.white,
            onPressed: () {},
            title: const CustomButtonTextWithIcon(
              text: 'Sign In with Apple',
              icon: Icon(
                FontAwesomeIcons.apple,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

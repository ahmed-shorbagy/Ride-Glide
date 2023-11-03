import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/face_book_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/google_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/user_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custombutton_text_and_icon.dart';

class OtherSignUpOptions extends StatelessWidget {
  const OtherSignUpOptions({
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
                GoRouter.of(context).pushReplacement(
                  AppRouter.kSetPhoneNumberView,
                );
                UserCubit.user.uId = auth.currentUser!.uid;
                debugPrint(' THIS IS THE USER iD  ${auth.currentUser!.uid}');
              }
            },
            builder: (context, state) {
              return CustomButton(
                onPressed: () async {
                  await BlocProvider.of<GoogleAuthCubit>(context)
                      .signUpWihGoogle();

                  if (state is GoogleAuthFaluire) {
                    snackBar(context, 'an error occurred please try again');
                  }
                },
                title: CustomButtonTextWithIcon(
                  text: 'Sign up with Gmail',
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
                GoRouter.of(context).pushReplacement(
                  AppRouter.kSetPhoneNumberView,
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                onPressed: () async {
                  await BlocProvider.of<FaceBookAuthCubit>(context)
                      .signUpWithFaceBook();

                  if (state is FaceBookAuthFaluire) {
                    snackBar(context, 'an error occurred please try again');
                  }
                },
                title: CustomButtonTextWithIcon(
                  text: 'Sign up with Facebook',
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
            onPressed: () {},
            title: const CustomButtonTextWithIcon(
              text: 'Sign up with Apple',
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

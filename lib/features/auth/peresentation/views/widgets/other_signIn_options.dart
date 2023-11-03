import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:ride_glide/constants.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/face_book_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/get_userData_cubit/get_user_data_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/google_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custombutton_text_and_icon.dart';

class OtherSignInOptions extends StatelessWidget {
  const OtherSignInOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetUserDataCubit, GetUserDataState>(
      listener: (context, state) async {
        if (state is GetUserDataSuccess) {
          var newuserbox = Hive.box<UserModel>(kUserBox);
          if (newuserbox.isNotEmpty) {
            newuserbox.deleteAt(0);
          }

          UserModel user = state.user;
          await newuserbox.add(user);
          debugPrint(
              'THIS IS THE USER INFO   ${newuserbox.values.first.adress} ${newuserbox.values.first.city}     ${newuserbox.values.first.name}  ${newuserbox.values.first.email}  ${newuserbox.values.first.gender}  ${newuserbox.values.first.phone}  ${newuserbox.values.first.imageUrl}  ${newuserbox.values.first.uId}');
          GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
              listener: (context, state) async {
                if (state is GoogleAuthSuccess) {
                  await BlocProvider.of<GetUserDataCubit>(context)
                      .getUserData(uId: auth.currentUser!.uid);
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
              listener: (context, state) async {
                if (state is FaceBookAuthSuccess) {
                  await BlocProvider.of<GetUserDataCubit>(context)
                      .getUserData(uId: auth.currentUser?.uid ?? "err");
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
      ),
    );
  }
}

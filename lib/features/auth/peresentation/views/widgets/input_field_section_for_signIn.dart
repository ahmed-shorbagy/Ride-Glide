import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:ride_glide/constants.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/email_paswword_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/get_userData_cubit/get_user_data_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/user_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_text_search_field.dart';

class InputFieldsSectionForSignIn extends StatefulWidget {
  const InputFieldsSectionForSignIn({
    super.key,
  });

  @override
  State<InputFieldsSectionForSignIn> createState() =>
      _InputFieldsSectionForSignInState();
}

class _InputFieldsSectionForSignInState
    extends State<InputFieldsSectionForSignIn> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autoValidateMode,
      key: formKey,
      child: BlocListener<GetUserDataCubit, GetUserDataState>(
        listener: (context, state) async {
          if (state is GetUserDataSuccess) {
            var newuserbox = Hive.box<UserModel>(kUserBox);
            if (newuserbox.isNotEmpty) {
              newuserbox.deleteAt(0);
            }
            UserModel user = state.user;
            await newuserbox.add(user);
            if (context.mounted) {}
          } else if (state is GetUserDataFaluire) {
            snackBar(context, state.errMessage);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                onChanged: (value) {
                  email = value;
                },
                hintText: ' Enter Your Email',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                hintText: 'Enter Your Password',
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            GestureDetector(
              onTap: () {
                GoRouter.of(context)
                    .pushReplacement(AppRouter.kverifyEmailView);
              },
              child: Text(
                'Forget password?',
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.red, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 38,
            ),
            BlocConsumer<EmailPaswwordCubit, EmailPaswwordState>(
              listener: (context, state) async {
                if (state is EmailPaswwordSuccess) {
                  await BlocProvider.of<GetUserDataCubit>(context)
                      .getUserData(uId: auth.currentUser?.uid ?? "err");
                  UserCubit.user.uId = auth.currentUser?.uid;
                }
                if (state is EmailPaswwordFaluire) {
                  snackBar(context, state.errMessage);
                }
              },
              builder: (context, state) {
                return CustomButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        BlocProvider.of<EmailPaswwordCubit>(context)
                            .signInUser(email: email!, password: password!);
                      }
                    },
                    title: state is EmailPaswwordLoadin
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white, fontSize: 16),
                          ),
                    backgroundColor: Theme.of(context).primaryColor);
              },
            ),
          ],
        ),
      ),
    );
  }
}

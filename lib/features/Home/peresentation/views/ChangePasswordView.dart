import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:ride_glide/constants.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/change_password_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/user_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_text_search_field.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/sePassword_view_body.dart';
import 'package:ride_glide/generated/l10n.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController _passwordController = TextEditingController();
TextEditingController _confirmPasswordController = TextEditingController();
bool passwordsMatch = true;
UserModel user = Hive.box<UserModel>(kUserBox).values.first;

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60, bottom: 30),
            child: CustomAppBar(),
          ),
          Text(
            S.of(context).SetPassword,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 76),
            child: Text(
              S.of(context).SetPassword,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: CustomTextField(
                obscuretext: !isVisible,
                suffixIcon: isVisible
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: const Icon(
                          Icons.visibility,
                          color: Colors.grey,
                        ))
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: const Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        )),
                onChanged: (value) {
                  _passwordController.text = value;
                },
                hintText: S.of(context).EnterYourPassword),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: CustomTextField(
                obscuretext: !isVisible,
                suffixIcon: isVisible
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: const Icon(
                          Icons.visibility,
                          color: Colors.grey,
                        ))
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: const Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        )),
                onChanged: (value) {
                  _confirmPasswordController.text = value;
                },
                hintText: S.of(context).ConfirmPassword),
          ),
          if (!passwordsMatch)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                S.of(context).PasswordDontMatch,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const Spacer(
            flex: 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                if (state is ChangePasswordSuccess) {
                  user.password = _confirmPasswordController.text;
                  snackBar(context, S.of(context).PasswordChangedSuccessfully);
                } else if (state is ChangePasswordFaluire) {
                  snackBar(context, state.errMessage);
                }
              },
              builder: (context, state) {
                return CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Password validation logic
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          setState(() {
                            passwordsMatch = false;
                          });
                        } else {
                          setState(() {
                            passwordsMatch = true;
                          });

                          UserCubit.user.password =
                              _confirmPasswordController.text;
                        }
                        await BlocProvider.of<ChangePasswordCubit>(context)
                            .updatePassword(
                                newPassword: _confirmPasswordController.text);
                      }
                    },
                    title: state is ChangePasswordLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            S.of(context).SaveChanges,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white, fontSize: 16),
                          ),
                    backgroundColor: Theme.of(context).primaryColor);
              },
            ),
          ),
          const Spacer(
            flex: 1,
          )
        ],
      ),
    ));
  }
}

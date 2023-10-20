import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/email_paswword_cubit.dart';

import 'package:ride_glide/features/auth/peresentation/manager/cubit/user_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_text_search_field.dart';

class SetPasswordviewBody extends StatefulWidget {
  const SetPasswordviewBody({
    super.key,
  });

  @override
  State<SetPasswordviewBody> createState() => _SetPasswordviewBodyState();
}

bool isVisible = false;

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController _passwordController = TextEditingController();
TextEditingController _confirmPasswordController = TextEditingController();
bool passwordsMatch = true; // Initially assume passwords match

class _SetPasswordviewBodyState extends State<SetPasswordviewBody> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60, bottom: 30),
            child: CustomAppBar(),
          ),
          Text(
            'Set Password',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 76),
            child: Text(
              'Set Your Password',
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
                hintText: 'Enter your password'),
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
                hintText: 'Confirm your password'),
          ),
          if (!passwordsMatch)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                'Passwords do not match',
                style: TextStyle(
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
            child: BlocConsumer<EmailPaswwordCubit, EmailPaswwordState>(
              listener: (context, state) {
                if (state is EmailPaswwordSuccess) {
                  UserCubit.user.uId = auth.currentUser!.uid;
                  GoRouter.of(context)
                      .pushReplacement(AppRouter.kSetProfileView);
                } else if (state is EmailPaswwordFaluire) {
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
                        await BlocProvider.of<EmailPaswwordCubit>(context)
                            .signupUser(
                                email: UserCubit.user.email ?? '',
                                password: UserCubit.user.password!);
                      }
                    },
                    title: state is EmailPaswwordLoadin
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Register',
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
    );
  }
}

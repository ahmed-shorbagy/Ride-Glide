import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_text_search_field.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

GlobalKey<FormState> formKey = GlobalKey();
String email = '';

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
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
                  'Verifivation email ',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              CustomTextField(
                  onChanged: (value) {
                    email = value;
                  },
                  hintText: 'Enter your Email '),
              const Spacer(
                flex: 9,
              ),
              CustomButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      var verify = await AuthRepo().verifyEmail(email: email);
                      if (verify) {
                        AuthRepo().updateUserPassword(email: email);
                        snackBar(context,
                            'a reset email is sent to this email please check');
                        GoRouter.of(context)
                            .pushReplacement(AppRouter.kSignInView);
                      } else {
                        snackBar(context, 'email not found');
                      }
                    }
                  },
                  title: const Text('Change Password'),
                  backgroundColor: Theme.of(context).primaryColor),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

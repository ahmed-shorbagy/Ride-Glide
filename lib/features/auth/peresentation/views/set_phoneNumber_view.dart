import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/phone_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/user_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_drop_down_dield.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_phoneField.dart';

class SetPhoneNumberView extends StatefulWidget {
  const SetPhoneNumberView({super.key});

  @override
  State<SetPhoneNumberView> createState() => _SetPhoneNumberViewState();
}

AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
GlobalKey<FormState> formKey = GlobalKey();

class _SetPhoneNumberViewState extends State<SetPhoneNumberView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(
                flex: 2,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: CustomPhoneField(
                      onChanged: (value) {
                        UserCubit.user.phone = value!.international;
                      },
                      autoValidateMode: autoValidateMode)),
              CustomDropdownTextField(
                onChanged: (value) {
                  UserCubit.user.gender = value.toString();
                },
                hintText: 'Gender',
              ),
              const Spacer(
                flex: 4,
              ),
              CustomButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      try {
                        await BlocProvider.of<PhoneAuthCubit>(context)
                            .initializephoneSignUp(
                                phoneNumber: UserCubit.user.phone);
                        GoRouter.of(context).pushReplacement(
                          AppRouter.kOTPViewForOtherSignUpOptions,
                        );
                      } catch (e) {
                        snackBar(
                            context, 'some thing went wrong please try again');
                      }
                    }
                  },
                  title: Text(
                    'Sign Up',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white, fontSize: 16),
                  ),
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

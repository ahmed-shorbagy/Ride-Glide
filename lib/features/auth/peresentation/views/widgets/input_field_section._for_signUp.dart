import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/phone_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/user_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_drop_down_dield.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_icon_and_rich_text.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_phoneField.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_text_search_field.dart';

class InputFieldsSectionForSignUp extends StatefulWidget {
  const InputFieldsSectionForSignUp({
    super.key,
  });

  @override
  State<InputFieldsSectionForSignUp> createState() =>
      _InputFieldsSectionForSignUpState();
}

class _InputFieldsSectionForSignUpState
    extends State<InputFieldsSectionForSignUp> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autoValidateMode,
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomTextField(
              onChanged: (value) {
                UserCubit.user.name = value;
              },
              hintText: 'Name',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomTextField(
              hintText: 'Email',
              onChanged: (value) {
                UserCubit.user.email = value;
              },
            ),
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
          const SizedBox(
            height: 22,
          ),
          const CustomIconAndRichText(),
          const SizedBox(
            height: 38,
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
                      AppRouter.kOTPView,
                    );
                  } catch (e) {
                    snackBar(context, 'some thing went wrong please try again');
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
        ],
      ),
    );
  }
}

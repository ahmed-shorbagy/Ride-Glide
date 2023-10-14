import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/phone_auth_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/user_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';

class OTPViewForOtherSignUpOptions extends StatelessWidget {
  const OTPViewForOtherSignUpOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60, bottom: 30),
            child: CustomAppBar(),
          ),
          Text(
            'Phone verification',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 76),
            child: Text(
              'Enter your OTP code',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: OTPTextField(
              length: 6,
              width: SizeConfig.screenwidth! * 0.6,
              fieldWidth: 40,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onChanged: (pin) {
                UserCubit.user.oTp = pin;
              },
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            maxLines: 2,
            text: TextSpan(
              text: "Didn't receive code? ",
              style: Theme.of(context).textTheme.bodyLarge!,
              children: <TextSpan>[
                TextSpan(
                    text: ' Resend again',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).primaryColor.withOpacity(0.7))),
              ],
            ),
          ),
          const Spacer(flex: 3),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return BlocListener<PhoneAuthCubit, PhoneAuthState>(
                    listener: (context, state) {
                      if (state is PhoneAuthSuccess) {
                        GoRouter.of(context).pushReplacement(
                          AppRouter.kSetProfileViewForOtherSignUpOptions,
                        );
                      }
                    },
                    child: CustomButton(
                        onPressed: () {
                          BlocProvider.of<PhoneAuthCubit>(context)
                              .verifyOTP(UserCubit.user.oTp ?? 'error');
                          if (state is PhoneAuthFaluire) {
                            snackBar(context, state.errMessage);
                          }
                        },
                        title: const Text('Verify'),
                        backgroundColor: Theme.of(context).primaryColor),
                  );
                },
              )),
          const Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/get_userData_cubit/delete_password_cubit/delete_password_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocListener<DeletePasswordCubit, DeletePasswordState>(
          listener: (context, state) {
            if (state is DeletePasswordSuccess) {
              GoRouter.of(context).pushReplacement(AppRouter.kSignUpView);
            }
            if (state is DeletePasswordFaluire) {
              snackBar(context, state.errMessage);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60, bottom: 30),
                child: CustomAppBar(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Are you sure you want to delete your account? Please read how account deletion will affect.Deleting your account removes personal information our database. Tour email becomes permanently reserved and same email cannot be re-use to register a new account.',
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                  onPressed: () async {
                    await BlocProvider.of<DeletePasswordCubit>(context)
                        .deleteAccount();
                  },
                  title: const Text('Delete'),
                  backgroundColor: Colors.red)
            ],
          ),
        ),
      ),
    );
  }
}

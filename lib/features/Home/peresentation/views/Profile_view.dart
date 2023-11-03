import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:ride_glide/constants.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_bottomBar.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_profile_data.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/log_out_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';
import 'package:ride_glide/generated/l10n.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = Hive.box<UserModel>(kUserBox).values.first;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 26),
                        child: CustomProfileHeadLine(),
                      ),
                      CustomProfileData(user: user),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32, horizontal: 16),
                        child: BlocListener<LogOutCubit, LogOutState>(
                          listener: (context, state) {
                            if (state is LogOutSuccess) {
                              GoRouter.of(context).pop();
                              GoRouter.of(context)
                                  .pushReplacement(AppRouter.kSignInView);
                            }
                            if (state is LogOutFaluire) {}
                          },
                          child: CustomButton(
                            onPressed: () async {
                              await BlocProvider.of<LogOutCubit>(context)
                                  .logOut();
                            },
                            title: BlocBuilder<LogOutCubit, LogOutState>(
                              builder: (context, state) {
                                if (state is LogOutLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Text(
                                    S.of(context).LogOut,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontSize: 16),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Align(
              alignment: FractionalOffset.bottomCenter,
              child: CustomBottombar()),
        ],
      ),
    );
  }
}

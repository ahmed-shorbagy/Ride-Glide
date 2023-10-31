import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:ride_glide/constants.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';
import 'package:ride_glide/features/auth/peresentation/manager/cubit/log_out_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = Hive.box<UserModel>(kUserBox).values.first;
    return BlocListener<LogOutCubit, LogOutState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          GoRouter.of(context).pop();
          GoRouter.of(context).pushReplacement(AppRouter.kSignInView);
        }
      },
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(82),
            topRight: Radius.circular(82),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: CustomAppBar(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: OvalBorder(
                        side:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    color: const Color(0xffD0D0D0),
                  ),
                  height: 90,
                  width: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: user.imageUrl!,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  '${user.name}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff5A5A5A)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    '${user.email}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              CustomDrawerElement(
                icon: Assets.HistoryIcon,
                title: 'History',
                onTap: () {},
              ),
              CustomDrawerElement(
                icon: Assets.ComplainIcon,
                title: 'Complain',
                onTap: () {},
              ),
              CustomDrawerElement(
                icon: Assets.RefferalIcon,
                title: 'Referral',
                onTap: () {},
              ),
              CustomDrawerElement(
                icon: Assets.AboutUsIcon,
                title: 'About Us',
                onTap: () {},
              ),
              CustomDrawerElement(
                icon: Assets.SettingsIcon,
                title: 'Settings',
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kSettingsView);
                },
              ),
              CustomDrawerElement(
                icon: Assets.HelpIcon,
                title: 'Help and Support',
                onTap: () {},
              ),
              CustomDrawerElement(
                icon: Assets.LogOutIcon,
                title: 'Log Out',
                onTap: () async {
                  await BlocProvider.of<LogOutCubit>(context).logOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDrawerElement extends StatelessWidget {
  const CustomDrawerElement({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });
  final String title;
  final String icon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            icon,
            scale: 0.7,
          ),
          title: Text(title),
          titleTextStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontWeight: FontWeight.bold),
          onTap: onTap,
        ),
        const Divider(
          thickness: 1.5,
        )
      ],
    );
  }
}

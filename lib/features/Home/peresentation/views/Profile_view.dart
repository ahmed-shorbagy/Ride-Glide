import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:ride_glide/constants.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_bottomBar.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_phoneField.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_text_search_field.dart';

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
                        child: CustomButton(
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            try {
                              await auth.signOut();
                              GoRouter.of(context)
                                  .pushReplacement(AppRouter.kSignInView);
                            } catch (e) {
                              snackBar(context, e.toString());
                            }
                          },
                          title: Text(
                            'Log Out',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16),
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

class CustomProfileData extends StatelessWidget {
  const CustomProfileData({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Container(
              decoration: ShapeDecoration(
                shape: OvalBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                color: const Color(0xffD0D0D0),
              ),
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: user.imageUrl!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              '${user.name}',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold, color: const Color(0xff5A5A5A)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CustomTextField(
            onChanged: (value) {
              user.email = value;
            },
            hintText: '',
            initialValue: user.email ?? '',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CustomTextField(
            onChanged: (value) {
              user.email = value;
            },
            hintText: '',
            initialValue: user.adress ?? '',
          ),
        ),
        CustomPhoneField(
          autoValidateMode: AutovalidateMode.always,
          onChanged: (value) {},
          initialValue:
              PhoneNumber(isoCode: IsoCode.EG, nsn: user.phone.substring(3)),
        ),
      ],
    );
  }
}

class CustomProfileHeadLine extends StatelessWidget {
  const CustomProfileHeadLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomButton(
              backgroundColor: const Color(0xff8AD4B5),
              onPressed: () {},
              title: const Icon(
                Icons.menu,
                color: Colors.black,
              )),
        ),
        SizedBox(
          width: SizeConfig.screenwidth! * 0.22,
        ),
        Center(
          child: Text(
            'Profile',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

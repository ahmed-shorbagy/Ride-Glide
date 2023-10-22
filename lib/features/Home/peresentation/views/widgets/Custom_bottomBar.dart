import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_icon_wihtLabel.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_hexagon_withLabel.dart';

class CustomBottombar extends StatefulWidget {
  const CustomBottombar({
    super.key,
  });

  @override
  State<CustomBottombar> createState() => _CustomBottombarState();
}

bool homeIconPressed = true;
bool favoriteIconPressed = false;
bool offerIconPressed = false;
bool profileIconPressed = false;

class _CustomBottombarState extends State<CustomBottombar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenwidth,
      height: 80,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),
      child: SizedBox(
        width: SizeConfig.screenwidth,
        child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.defaultSize! * 2),
                      child: IconWithLabel(
                        iconColor: homeIconPressed ? Colors.green : Colors.grey,
                        textColor: homeIconPressed ? Colors.green : Colors.grey,
                        onTap: () {
                          setState(() {
                            homeIconPressed = true;
                            favoriteIconPressed = false;
                            offerIconPressed = false;
                            profileIconPressed = false;
                          });
                          GoRouter.of(context)
                              .pushReplacement(AppRouter.kHomeView);
                        },
                        imageName: Assets.HomeIcon,
                        label: 'Home',
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.defaultSize! * 2),
                      child: IconWithLabel(
                        iconColor:
                            favoriteIconPressed ? Colors.green : Colors.grey,
                        textColor:
                            favoriteIconPressed ? Colors.green : Colors.grey,
                        onTap: () {
                          setState(() {
                            homeIconPressed = false;
                            favoriteIconPressed = true;
                            offerIconPressed = false;
                            profileIconPressed = false;
                          });
                        },
                        imageName: Assets.HeartIcon,
                        label: 'Favourite',
                      )),
                  const SizedBox(
                    width: 50,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.defaultSize! * 4),
                      child: IconWithLabel(
                        iconColor:
                            offerIconPressed ? Colors.green : Colors.grey,
                        textColor:
                            offerIconPressed ? Colors.green : Colors.grey,
                        onTap: () {
                          setState(() {
                            homeIconPressed = false;
                            favoriteIconPressed = false;
                            offerIconPressed = true;
                            profileIconPressed = false;
                          });
                        },
                        imageName: Assets.DicountIcon,
                        label: 'Offer',
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.defaultSize! * 2),
                      child: IconWithLabel(
                        iconColor:
                            profileIconPressed ? Colors.green : Colors.grey,
                        textColor:
                            profileIconPressed ? Colors.green : Colors.grey,
                        onTap: () {
                          setState(() {
                            homeIconPressed = false;
                            favoriteIconPressed = false;
                            offerIconPressed = false;
                            profileIconPressed = true;
                          });
                          GoRouter.of(context).push(AppRouter.kProfileView);
                        },
                        imageName: Assets.UserIcon,
                        label: 'Profile',
                      )),
                ],
              ),
              Positioned(
                  bottom: 19,
                  left: SizeConfig.screenwidth! * 0.38,
                  child: const CustomhexagonWithLabel()),
            ]),
      ),
    );
  }
}

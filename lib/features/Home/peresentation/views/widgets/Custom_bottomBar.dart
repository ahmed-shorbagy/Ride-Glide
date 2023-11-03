import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_icon_wihtLabel.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_hexagon_withLabel.dart';
import 'package:ride_glide/generated/l10n.dart';

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
      decoration: ShapeDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        shape: const RoundedRectangleBorder(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        IconWithLabel(
                          iconColor:
                              homeIconPressed ? Colors.green : Colors.grey,
                          textColor:
                              homeIconPressed ? Colors.green : Colors.grey,
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
                          label: S.of(context).bottomBarHome,
                        ),
                        const Gap(32),
                        IconWithLabel(
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
                          label: S.of(context).bottomBarFavourite,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconWithLabel(
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
                          label: S.of(context).bottomBarOffer,
                        ),
                        const Gap(32),
                        IconWithLabel(
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
                          label: S.of(context).bottomBarProifle,
                        ),
                      ],
                    ),
                  )
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

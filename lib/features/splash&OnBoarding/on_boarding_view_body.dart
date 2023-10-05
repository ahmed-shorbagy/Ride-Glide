import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/App_images.dart';
import '../../core/utils/App_router.dart';
import '../../core/utils/size_config.dart';
import 'Custom_page_view.dart';
import 'on_boarding_custom_progress_button.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

PageController? pageController;

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            PageViewItem(
                text1: 'Anywhere you are',
                text2:
                    'Sell houses easily with the help of Listenoryx and to make this line big Iam writing more.',
                image: Assets.Group39335),
            PageViewItem(
                text1: 'At anytime',
                text2:
                    'Sell houses easily with the help of Listenoryx and to make this line big Iam writing more.',
                image: Assets.Group39337),
            PageViewItem(
                text1: 'Book your car',
                text2:
                    'Sell houses easily with the help of Listenoryx and to make this line big Iam writing more.',
                image: Assets.Group39336),
          ],
        ),
        Visibility(
          visible: pageController!.hasClients
              ? (pageController!.page == 2 ? false : true)
              : true,
          child: Positioned(
            top: SizeConfig.defaultSize! * 8,
            right: SizeConfig.defaultSize! * 3,
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context)
                    .pushReplacement(AppRouter.kAuthWelcomeView);
              },
              child: Text(
                'Skip',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        Positioned(
          right: SizeConfig.screenwidth! * 0.4,
          bottom: SizeConfig.screenhieght! * 0.15,
          child: const Onboardingcircleprogressbutton(),
        ),
      ],
    );
  }
}

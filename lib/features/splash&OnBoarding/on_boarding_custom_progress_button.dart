import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../core/utils/App_router.dart';
import 'custom_on_boarding_button.dart';
import 'on_boarding_view_body.dart';

class Onboardingcircleprogressbutton extends StatefulWidget {
  const Onboardingcircleprogressbutton({
    super.key,
  });

  @override
  State<Onboardingcircleprogressbutton> createState() =>
      _OnboardingcircleprogressbuttonState();
}

double perecent = 0;

class _OnboardingcircleprogressbuttonState
    extends State<Onboardingcircleprogressbutton> {
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      percent: perecent < 1 ? perecent : 1,
      progressColor: Theme.of(context).primaryColor,
      animation: true,
      circularStrokeCap: CircularStrokeCap.round,
      lineWidth: 4,
      backgroundColor: const Color.fromARGB(255, 186, 185, 229),
      center: CustomOnBoardingButton(
        ontap: () {
          setState(() {
            perecent += 0.3;
          });

          pageController!.page == 2
              ? GoRouter.of(context).pushReplacement(AppRouter.kAuthWelcomeView)
              : pageController!.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn);
        },
      ),
      radius: 41,
    );
  }
}

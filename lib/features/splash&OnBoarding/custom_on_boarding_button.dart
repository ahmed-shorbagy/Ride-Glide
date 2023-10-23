import 'package:flutter/material.dart';

import 'on_boarding_view_body.dart';

class CustomOnBoardingButton extends StatefulWidget {
  const CustomOnBoardingButton({
    super.key,
    required this.ontap,
  });
  final void Function()? ontap;

  @override
  State<CustomOnBoardingButton> createState() => _CustomOnBoardingButtonState();
}

class _CustomOnBoardingButtonState extends State<CustomOnBoardingButton> {
  @override
  void initState() {
    super.initState();

    pageController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        width: 70,
        height: 70,
        decoration: ShapeDecoration(
          color: const Color(0xFF08B783),
          shape: OvalBorder(
              side: BorderSide(color: Theme.of(context).primaryColor)),
        ),
        child: pageController!.page == 2
            ? Center(
                child: Text('Go',
                    style: Theme.of(context).textTheme.headlineLarge),
              )
            : const Icon(
                Icons.arrow_forward,
                color: Color(0xff5A5A5A),
              ),
      ),
    );
  }
}

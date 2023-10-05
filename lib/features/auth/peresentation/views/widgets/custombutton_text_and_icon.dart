import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButtonTextWithIcon extends StatelessWidget {
  const CustomButtonTextWithIcon({
    super.key,
    required this.icon,
    required this.text,
  });
  final Widget icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10), child: icon),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}

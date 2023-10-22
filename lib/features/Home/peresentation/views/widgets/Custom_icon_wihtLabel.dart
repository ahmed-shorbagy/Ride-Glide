import 'package:flutter/material.dart';

class IconWithLabel extends StatelessWidget {
  const IconWithLabel({
    super.key,
    required this.imageName,
    required this.label,
    required this.onTap,
    required this.iconColor,
    required this.textColor,
  });
  final String imageName;
  final String label;
  final void Function() onTap;
  final Color iconColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Image.asset(
            color: iconColor,
            imageName,
            scale: 1.6,
          ),
        ),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}

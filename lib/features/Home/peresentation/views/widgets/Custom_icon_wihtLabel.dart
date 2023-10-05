import 'package:flutter/material.dart';

class IconWithLabel extends StatelessWidget {
  const IconWithLabel({
    super.key,
    required this.imageName,
    required this.label,
  });
  final String imageName;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imageName,
          scale: 1.6,
        ),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        )
      ],
    );
  }
}

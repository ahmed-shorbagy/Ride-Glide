import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.backgroundColor,
  });

  final void Function() onPressed;

  final Color? backgroundColor;
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
            backgroundColor: backgroundColor),
        onPressed: onPressed,
        child: title);
  }
}

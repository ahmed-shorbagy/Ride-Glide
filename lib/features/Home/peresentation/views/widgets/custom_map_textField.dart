import 'package:flutter/material.dart';
import 'package:ride_glide/core/utils/App_images.dart';

class CustomMapTextField extends StatelessWidget {
  const CustomMapTextField(
      {super.key,
      required this.onTap,
      required this.hintText,
      required this.prefixIcon,
      required this.controller});

  final void Function() onTap;
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style:
          Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.grey),
          suffixIcon: Image.asset(
            Assets.HeartIcon,
            scale: 1.7,
          ),
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          fillColor: const Color(0xffE2F5ED)),
    );
  }
}

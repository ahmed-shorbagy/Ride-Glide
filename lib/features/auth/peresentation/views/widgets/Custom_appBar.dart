import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/generated/l10n.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: isArabic()
              ? const Icon(Icons.arrow_left_sharp)
              : const Icon(Icons.arrow_back_ios_new),
        ),
        Text(
          S.of(context).Back,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

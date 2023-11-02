import 'package:flutter/material.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/generated/l10n.dart';

class CustomRowText extends StatelessWidget {
  const CustomRowText({
    super.key,
    required this.onTap,
  });
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Assets.MarkerIcon,
          scale: 4,
          color: Theme.of(context).primaryColor,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            S.of(context).ChooseOnMap,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        )
      ],
    );
  }
}

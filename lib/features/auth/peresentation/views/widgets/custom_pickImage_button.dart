import 'package:flutter/material.dart';

class CustomPickImageButton extends StatelessWidget {
  const CustomPickImageButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  final void Function() onTap;
  final Image? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: ShapeDecoration(
            shape: OvalBorder(
                side: BorderSide(color: Theme.of(context).primaryColor)),
            color: const Color(0xffD0D0D0),
          ),
          height: 120,
          width: 120,
          child:
              ClipRRect(borderRadius: BorderRadius.circular(120), child: child),
        ),
        Positioned(
          right: 4,
          bottom: 4,
          child: GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

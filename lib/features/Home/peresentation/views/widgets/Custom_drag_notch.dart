import 'package:flutter/material.dart';

class CustomDragNotch extends StatelessWidget {
  const CustomDragNotch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 134,
      height: 5,
      decoration: ShapeDecoration(
        color: const Color(0xFF141414),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomTansportTypeCard extends StatelessWidget {
  const CustomTansportTypeCard({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });
  final String icon;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        width: 160,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(16))),
          color: const Color(0xff08B783).withOpacity(0.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              scale: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(title, style: Theme.of(context).textTheme.bodyLarge)
          ],
        ),
      ),
    );
  }
}

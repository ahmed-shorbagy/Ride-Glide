import 'package:flutter/material.dart';

class CustomPaymentMethodCard extends StatelessWidget {
  const CustomPaymentMethodCard({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  final String icon;
  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(6))),
          color: const Color(0xff08B783).withOpacity(0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Image.asset(
                icon,
                scale: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child:
                    Text(text, style: Theme.of(context).textTheme.bodyLarge!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

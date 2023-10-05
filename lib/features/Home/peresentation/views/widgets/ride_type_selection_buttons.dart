import 'package:flutter/material.dart';

import 'custom_style_button.dart';

class RideTypeSelectionButtons extends StatefulWidget {
  const RideTypeSelectionButtons({
    super.key,
  });

  @override
  State<RideTypeSelectionButtons> createState() =>
      _RideTypeSelectionButtonsState();
}

bool isActive1 = true;
bool isActive2 = false;

class _RideTypeSelectionButtonsState extends State<RideTypeSelectionButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomStyleButton(
            onPressed: () {
              setState(() {
                isActive1 = true;

                isActive2 = false;
              });
            },
            backGroundColor: isActive1
                ? Theme.of(context).primaryColor
                : const Color(0xffE2F5ED),
            text: Text(
              'Transport',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: isActive1 ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(8),
                topLeft: const Radius.circular(8),
                topRight: isActive1 ? const Radius.circular(8) : Radius.zero,
                bottomRight:
                    isActive1 ? const Radius.circular(8) : Radius.zero),
          ),
        ),
        Expanded(
          child: CustomStyleButton(
            onPressed: () {
              setState(() {
                isActive1 = false;

                isActive2 = true;
              });
            },
            backGroundColor: isActive2
                ? Theme.of(context).primaryColor
                : const Color(0xffE2F5ED),
            text: Text(
              'Delivey',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: isActive2 ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            borderRadius: BorderRadius.only(
                bottomRight: const Radius.circular(8),
                topRight: const Radius.circular(8),
                topLeft: isActive2 ? const Radius.circular(8) : Radius.zero,
                bottomLeft: isActive2 ? const Radius.circular(8) : Radius.zero),
          ),
        ),
      ],
    );
  }
}

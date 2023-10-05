import 'package:flutter/material.dart';

import '../../core/utils/size_config.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem(
      {super.key,
      required this.text1,
      required this.text2,
      required this.image});
  final String text1;
  final String text2;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.defaultSize! * 18,
        ),
        SizedBox(height: 200, child: Image.asset(image)),
        SizedBox(
          height: SizeConfig.defaultSize! * 4,
        ),
        Text(
          text1,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: SizeConfig.defaultSize! * 2,
        ),
        SizedBox(
          width: SizeConfig.screenwidth! * 0.6,
          child: Text(
            text2,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey),
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

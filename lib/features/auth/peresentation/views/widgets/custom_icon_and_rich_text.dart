import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride_glide/core/utils/size_config.dart';

class CustomIconAndRichText extends StatelessWidget {
  const CustomIconAndRichText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.check_circle_outline,
          color: Theme.of(context).primaryColor.withOpacity(0.7),
        ),
        SizedBox(
          width: SizeConfig.screenwidth! * 0.8,
          child: RichText(
            maxLines: 2,
            text: TextSpan(
              text: 'By signing up. you agree to the',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey),
              children: <TextSpan>[
                TextSpan(
                    text: ' Terms of service',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).primaryColor.withOpacity(0.7))),
                const TextSpan(text: ' and '),
                TextSpan(
                    text: ' Privacy policy .',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).primaryColor.withOpacity(0.7))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

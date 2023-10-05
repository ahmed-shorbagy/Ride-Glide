import 'package:flutter/material.dart';

import 'splash_view_body.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return SlideTransition(
            position: animation,
            child: Text(
              textAlign: TextAlign.center,
              'Seamless rides at your fingertips',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        });
  }
}

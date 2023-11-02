import 'package:flutter/material.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/generated/l10n.dart';

class SlideAnimationWidget extends StatefulWidget {
  const SlideAnimationWidget({super.key});

  @override
  _SlideAnimationWidgetState createState() => _SlideAnimationWidgetState();
}

class _SlideAnimationWidgetState extends State<SlideAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Define the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust the duration as needed
    );

    // Define the animation using a Tween
    _animation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Start off-screen at the bottom
      end: Offset.zero, // End at its final position
    ).animate(_controller);

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        height: 60,
        width: SizeConfig.screenwidth! * 0.8,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          color: const Color(0xff08B783).withOpacity(0.2),
        ),
        child: Center(
          child: Text(
            S.of(context).JustTapOnyourDesiredLocation,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';

class PaymentSuccessViewBody extends StatelessWidget {
  const PaymentSuccessViewBody({super.key, required this.driver});
  final DriverModel driver;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          Assets.PaymentSuccess,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Thank you',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          'Your booking has been placed sent to ',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          '${driver.name}',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

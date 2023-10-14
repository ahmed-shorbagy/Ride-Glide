import 'package:flutter/material.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Payment_success_view_body.dart';

class PaymentSuccessView extends StatelessWidget {
  const PaymentSuccessView({super.key, required this.driver});
  final DriverModel driver;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaymentSuccessViewBody(
        driver: driver,
      ),
    );
  }
}

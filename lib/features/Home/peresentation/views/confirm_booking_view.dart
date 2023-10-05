import 'package:flutter/material.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Confirm_booking_viewBody.dart';

class COnfirmBookingView extends StatelessWidget {
  const COnfirmBookingView({super.key, required this.driver});
  final DriverModel driver;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConfirmBookingViewBody(
        driver: driver,
      ),
    );
  }
}

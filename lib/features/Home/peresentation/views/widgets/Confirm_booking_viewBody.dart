import 'package:flutter/material.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/confirm_booking_custom_card.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';

class ConfirmBookingViewBody extends StatelessWidget {
  const ConfirmBookingViewBody({super.key, required this.driver});
  final DriverModel driver;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60, bottom: 10),
              child: CustomAppBar(),
            ),
            Center(
              child: Text(
                'Request for rent',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff5A5A5A)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomConfirmBookingCard(driver: driver),
            ),
          ],
        ),
      ),
    );
  }
}

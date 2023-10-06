import 'package:flutter/material.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_LocationDestinationColumn.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/confirm_booking_custom_card.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_payment_Method_card.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(
              height: 20,
            ),
            const LocationDestinationColumn(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomConfirmBookingCard(driver: driver),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Charge',
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total =  ${(travelDistance * 8).toStringAsFixed(2)}  EGP',
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              'Select payment method',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500, color: const Color(0xff5A5A5A)),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomPaymentMethodCard(
                  icon: Assets.VisaIcon, text: 'Pay with your visa card'),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomPaymentMethodCard(
                  icon: Assets.CashIcon, text: 'Pay Cash'),
            ),
          ],
        ),
      ),
    );
  }
}

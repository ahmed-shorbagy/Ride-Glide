import 'package:flutter/material.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';

class CustomConfirmBookingCard extends StatelessWidget {
  const CustomConfirmBookingCard({
    super.key,
    required this.driver,
  });

  final DriverModel driver;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        color: const Color(0xff08B783).withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: SizedBox(
                  width: 180,
                  child: Text(
                    '${driver.carType} | ${driver.carColor}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Image.asset(Assets.MarkerIcon, scale: 4),
                    SizedBox(
                      width: 100,
                      child: Text('${driver.adress} ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Image.asset(Assets.StarIcon, scale: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('4.9 (531 reviews)',
                          style: Theme.of(context).textTheme.bodyMedium!),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Image.asset(
                  Assets.StyleCarIcon,
                  scale: 1.9,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_network_image.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';

class CustomAvaliableDriversCard extends StatelessWidget {
  const CustomAvaliableDriversCard({
    super.key,
    required this.driver,
    required this.onPressed,
  });
  final DriverModel driver;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        color: const Color(0xff08B783).withOpacity(0.2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Text(
                      '${driver.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text('${driver.carType} | ${driver.carColor}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        Image.asset(Assets.MarkerIcon, scale: 4),
                        Text('${driver.adress} ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold)),
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
                    child: CustomNetworkImage(driver: driver),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            width: SizeConfig.screenwidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CustomButton(
                  onPressed: onPressed,
                  title: const Text('Book Now'),
                  backgroundColor: Theme.of(context).primaryColor),
            ),
          )
        ],
      ),
    );
  }
}

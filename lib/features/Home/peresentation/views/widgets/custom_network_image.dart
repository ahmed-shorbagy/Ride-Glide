import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.driver,
  });

  final DriverModel driver;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape:
            OvalBorder(side: BorderSide(color: Theme.of(context).primaryColor)),
        color: const Color(0xffD0D0D0),
      ),
      height: 80,
      width: 80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(120),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: driver.imageUrl ?? '',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

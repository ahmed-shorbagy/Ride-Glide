import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_destination_cubit/pick_destination_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_location_cubit/pick_location_cubit.dart';

class LocationDestinationColumn extends StatelessWidget {
  const LocationDestinationColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              Assets.MarkerIcon,
              scale: 4,
              color: Theme.of(context).hoverColor,
            ),
            SizedBox(
              width: 200,
              child: Text(
                '  ${PickLocationCubit.location?.result?.name}',
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Image.asset(
              Assets.MarkerIcon,
              scale: 4,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 200,
              child: Text(
                '${PickDestinationCubit.destination?.result?.name}',
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: SizeConfig.screenwidth! * 0.1,
            ),
            Text(
              '${travelDistance.toStringAsFixed(2)} Km',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ],
    );
  }
}

double travelDistance = calculateDistance(
    LatLng(PickLocationCubit.location?.result?.geometry?.location?.lat ?? 0,
        PickLocationCubit.location?.result?.geometry?.location?.lng ?? 0),
    LatLng(
        PickDestinationCubit.destination?.result?.geometry?.location?.lat ?? 0,
        PickDestinationCubit.destination?.result?.geometry?.location?.lng ??
            0));

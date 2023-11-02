import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_destination_cubit/pick_destination_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_location_cubit/pick_location_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Place_details_cubit/place_details_cubit_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_BottomSheet_for_PickLocation.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_bottomSheet_for_PickDestination.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_map_textField.dart';
import 'package:ride_glide/generated/l10n.dart';

class CustomFloatingAppBoxForChooseOnMap extends StatelessWidget {
  const CustomFloatingAppBoxForChooseOnMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 170,
        width: SizeConfig.screenwidth! * 0.9,
        decoration: const ShapeDecoration(
          color: Color(0xffB9E5D1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: BlocListener<PickLocationCubit, PickLocationState>(
                listener: (context, state) {
                  if (state is PickLocationSucceess) {
                    PickLocationCubit.location = state.placeDetails;
                  }
                },
                child: CustomMapTextField(
                  controller: PickLocationCubit.locationPlaceController,
                  hintText: S.of(context).location,
                  prefixIcon: GestureDetector(
                    onTap: () async {
                      PickLocationCubit.locationPlaceController.text =
                          'Current Location';
                      var location = await determinePosition();
                      await BlocProvider.of<PickLocationCubit>(context)
                          .getPlaceDetailsFromLocation(
                              latitude: location.latitude,
                              longitude: location.longitude);
                      BlocProvider.of<PlaceDetailsCubit>(context)
                          .notifyCustomButton();
                    },
                    child: Image.asset(
                      Assets.LocationIcon,
                      scale: 2,
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18))),
                      context: context,
                      builder: (context) {
                        return const CustomLocationBottomSheet();
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomMapTextField(
                controller: PickDestinationCubit.destinationPlacecontroller,
                hintText: S.of(context).Destination,
                prefixIcon: Image.asset(
                  Assets.MarkerIcon,
                  scale: 4,
                ),
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18))),
                    context: context,
                    builder: (context) {
                      return const CustomDestinationBottomsheet();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_destination_cubit/pick_destination_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_ListViewAutoComplete_Destination.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_drag_notch.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_row_text.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_rideInfo_textFields.dart';

class CustomDestinationBottomsheet extends StatefulWidget {
  const CustomDestinationBottomsheet({super.key});

  @override
  State<CustomDestinationBottomsheet> createState() =>
      _CustomDestinationBottomsheetState();
}

class _CustomDestinationBottomsheetState
    extends State<CustomDestinationBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenhieght! * 0.8,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: CustomDragNotch(),
          ),
          Text(
            'Select address',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              thickness: 2,
            ),
          ),
          CustomRideInfoTextFields(
            controller: PickDestinationCubit.destinationPlacecontroller,
          ),
          const Divider(
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomRowText(
              onTap: () {
                GoRouter.of(context)
                    .push(AppRouter.kChooseDestinationOnMapView);
              },
            ),
          ),
          const CustomListViewAutoCompleteDestination()
        ],
      ),
    );
  }
}

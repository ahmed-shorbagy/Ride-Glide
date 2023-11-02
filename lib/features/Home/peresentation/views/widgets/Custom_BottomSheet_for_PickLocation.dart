import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_location_cubit/pick_location_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_ListViewAutoCOmplete_ForLocation.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_drag_notch.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_row_text.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_rideInfo_textFields.dart';
import 'package:ride_glide/generated/l10n.dart';

class CustomLocationBottomSheet extends StatefulWidget {
  const CustomLocationBottomSheet({super.key});

  @override
  State<CustomLocationBottomSheet> createState() =>
      _CustomLocationBottomSheetState();
}

class _CustomLocationBottomSheetState extends State<CustomLocationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenhieght! * 0.8,
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: CustomDragNotch()),
          Text(
            S.of(context).SelectAddress,
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
            hintText: S.of(context).From,
            controller: PickLocationCubit.locationPlaceController,
          ),
          const Divider(
            thickness: 2,
          ),
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomRowText(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kChooseLocationOnMapView);
                },
              )),
          const CustomListViewAutoCOmpleteForLocation()
        ],
      ),
    );
  }
}

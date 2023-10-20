import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_location_cubit/pick_location_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Place_AutoComplete_cubit/place_auto_complete_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_text_search_field.dart';

class CustomRideInfoTextFields extends StatelessWidget {
  const CustomRideInfoTextFields({
    super.key,
    required this.controller,
    required this.hintText,
  });
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: CustomTextField(
            textEditingController: controller,
            onChanged: (value) async {
              await BlocProvider.of<PlaceAutoCompleteCubit>(context)
                  .placeAutoComplete(searchedInput: value);
            },
            hintText: hintText,
            suffixIcon: GestureDetector(
              onTap: () {
                PickLocationCubit.locationPlaceController.text =
                    'Current Location';
              },
              child: Image.asset(
                Assets.LocationIcon,
                scale: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

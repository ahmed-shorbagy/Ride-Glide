import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_destination_cubit/pick_destination_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Place_AutoComplete_cubit/place_auto_complete_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Place_details_cubit/place_details_cubit_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/recent_places_custom_card.dart';

class CustomListViewAutoCompleteDestination extends StatelessWidget {
  const CustomListViewAutoCompleteDestination({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceAutoCompleteCubit, PlaceAutoCompleteState>(
      builder: (context, state) {
        if (state is PlaceAutoCompleteSuccess) {
          return SizedBox(
            height: SizeConfig.screenhieght! * 0.39,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.placesSuggestionList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child:
                      BlocListener<PickDestinationCubit, PickDestinationState>(
                    listener: (context, state) {
                      if (state is PickDestinationSuccess) {
                        PickDestinationCubit.destination = state.placeDetails;
                      }
                    },
                    child: PlacesCustomListItem(
                      place: state.placesSuggestionList[index],
                      onTap: () async {
                        await BlocProvider.of<PickDestinationCubit>(context)
                            .getPlaceDetails(
                                placeID:
                                    state.placesSuggestionList[index].placeId ??
                                        '');
                        PickDestinationCubit.destinationPlacecontroller.text =
                            state.placesSuggestionList[index]
                                    .structuredFormatting?.mainText ??
                                '';

                        BlocProvider.of<PlaceDetailsCubit>(context)
                            .notifyCustomButton();
                        GoRouter.of(context).pop();
                      },
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is PlaceAutoCompleteLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PlaceAutoCompleteFaluire) {
          return Center(
            child: Text(state.errMessage),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

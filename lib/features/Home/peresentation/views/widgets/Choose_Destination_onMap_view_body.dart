import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_destination_cubit/pick_destination_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Place_details_cubit/place_details_cubit_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_floating_appBoxFor_chooseOnMap.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_slide%20transition_widget.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';
import 'package:ride_glide/generated/l10n.dart';

class ChooseDestinationOnMapViewBody extends StatefulWidget {
  const ChooseDestinationOnMapViewBody({
    super.key,
  });

  @override
  State<ChooseDestinationOnMapViewBody> createState() =>
      _ChooseLocationOnMapViewBodyState();
}

GoogleMapController? mapController;
LatLng currentPosition = const LatLng(30.0444, 31.2357);
BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
String? fromPlaceName;
String? toPlaceName;
bool doneTapped = false;

@override
class _ChooseLocationOnMapViewBodyState
    extends State<ChooseDestinationOnMapViewBody> {
  @override
  void initState() {
    determinePosition();

    getBytesFromAsset(Assets.MarkerIcon, 100).then((onValue) {
      markerIcon = BitmapDescriptor.fromBytes(onValue);
    });
    super.initState();
  }

  // Function to handle map tap
  void _handleMapTap(LatLng tappedPosition) async {
    setState(() {
      currentPosition = tappedPosition;
    });
    await BlocProvider.of<PickDestinationCubit>(context)
        .getPlaceDetailsFromLocation(
            latitude: currentPosition.latitude,
            longitude: currentPosition.longitude);

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: tappedPosition, zoom: 17),
      ),
    );
    BlocProvider.of<PlaceDetailsCubit>(context).notifyCustomButton();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocListener<PickDestinationCubit, PickDestinationState>(
          listener: (context, state) {
            if (state is PickDestinationSuccess) {
              PickDestinationCubit.destination = state.placeDetails;
              PickDestinationCubit.destinationPlacecontroller.text =
                  state.placeDetails.result?.name ?? '';
            }
          },
          child: GoogleMap(
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              onMapCreated: (controller) {
                if (Theme.of(context).brightness == Brightness.dark) {
                  controller.setMapStyle(darkMapStyle);
                } else {
                  controller.setMapStyle(lightMapStyle);
                }
                setState(() {
                  mapController = controller;
                });
              },
              initialCameraPosition: const CameraPosition(
                  target: LatLng(30.0444, 31.2357), zoom: 14),
              markers: {
                Marker(
                  markerId: const MarkerId('current location'),
                  icon: markerIcon,
                  position: currentPosition,
                  infoWindow: const InfoWindow(
                    title: 'Current location',
                  ),
                ),
              },
              myLocationEnabled: true,
              compassEnabled: true,
              onTap: _handleMapTap),
        ),
        Positioned(
          bottom: SizeConfig.screenhieght! * 0.12,
          right: SizeConfig.screenhieght! * 0.014,
          child: SizedBox(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              backgroundColor: Colors.white,
              onPressed: () async {
                determinePosition().then((position) {
                  LatLng newLatLng =
                      LatLng(position.latitude, position.longitude);
                  setState(() {
                    currentPosition = newLatLng;
                  });

                  mapController?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(target: newLatLng, zoom: 17),
                    ),
                  );
                }).catchError((error) {
                  debugPrint('Error: $error');
                });
              },
              child: Image.asset(
                Assets.LocationIcon,
                scale: 1.6,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 80,
          left: 10,
          child: BlocBuilder<PickDestinationCubit, PickDestinationState>(
            builder: (context, state) {
              if (state is PickDestinationSuccess) {
                return CustomButton(
                    onPressed: () {
                      setState(() {
                        doneTapped = true;
                      });
                    },
                    title: Text(
                      S.of(context).Done,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    backgroundColor: Theme.of(context).primaryColor);
              } else if (state is PickDestinationFaluire) {
                return const SizedBox();
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        const Positioned(bottom: 100, left: 10, child: SlideAnimationWidget()),
        if (doneTapped)
          Positioned(
            bottom: SizeConfig.screenhieght! * 0.23,
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: CustomFloatingAppBoxForChooseOnMap()),
          ),
        BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
          builder: (context, state) {
            if (state is PlaceDetailsCubitLocationDestnationSelected) {
              return Positioned(
                bottom: SizeConfig.screenhieght! * 0.45,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(
                      onPressed: () {
                        GoRouter.of(context)
                            .push(AppRouter.kSelectTransportView);
                      },
                      title: Text(
                        '           ${S.of(context).OrderNow}           ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}

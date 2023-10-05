import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_location_cubit/pick_location_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Place_details_cubit/place_details_cubit_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_floating_appBoxFor_chooseOnMap.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_slide%20transition_widget.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';

class ChooseLocationOnMapViewBody extends StatefulWidget {
  const ChooseLocationOnMapViewBody({
    super.key,
  });

  @override
  State<ChooseLocationOnMapViewBody> createState() =>
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
    extends State<ChooseLocationOnMapViewBody> {
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
    await BlocProvider.of<PickLocationCubit>(context)
        .getPlaceDetailsFromLocation(
            latitude: currentPosition.latitude,
            longitude: currentPosition.longitude);
    BlocProvider.of<PlaceDetailsCubit>(context).notifyCustomButton();

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: tappedPosition, zoom: 17),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocListener<PickLocationCubit, PickLocationState>(
          listener: (context, state) {
            if (state is PickLocationSucceess) {
              PickLocationCubit.locationAddress =
                  state.placeDetails.result?.formattedAddress ?? '';
              PickLocationCubit.locationPlaceController.text =
                  state.placeDetails.result?.name ?? '';
            }
          },
          child: GoogleMap(
              zoomGesturesEnabled: true,
              onMapCreated: (controller) {
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
              mapType: MapType.terrain,
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
          child: BlocBuilder<PickLocationCubit, PickLocationState>(
            builder: (context, state) {
              if (state is PickLocationSucceess) {
                return CustomButton(
                    onPressed: () {
                      setState(() {
                        doneTapped = true;
                      });
                    },
                    title: Text(
                      'Done',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    backgroundColor: Theme.of(context).primaryColor);
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
                      onPressed: () {},
                      title: Text(
                        '            Order Now          ',
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

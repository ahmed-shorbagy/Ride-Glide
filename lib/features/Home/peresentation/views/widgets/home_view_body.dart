import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';

import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Place_details_cubit/place_details_cubit_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_bottomBar.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_floatin_app_box.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({Key? key, required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  GoogleMapController? mapController;
  LatLng currentPosition = const LatLng(30.0444, 31.2357);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    determinePosition();

    getBytesFromAsset(Assets.MarkerIcon, 100).then((onValue) {
      markerIcon = BitmapDescriptor.fromBytes(onValue);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
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
          initialCameraPosition:
              const CameraPosition(target: LatLng(30.0444, 31.2357), zoom: 14),
          markers: {
            Marker(
                markerId: const MarkerId(
                  'current location',
                ),
                icon: markerIcon,
                position: currentPosition,
                infoWindow: const InfoWindow(
                  title: 'Current location',
                ))
          },
          myLocationEnabled: true,
          compassEnabled: true,
        ),
        Positioned(
          bottom: SizeConfig.screenhieght! * 0.46,
          right: SizeConfig.screenhieght! * 0.06,
          child: SizedBox(
            height: 40,
            width: 40,
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
                scale: 2.1,
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 0,
          child: CustomBottombar(),
        ),
        Positioned(
          bottom: SizeConfig.screenhieght! * 0.23,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: CustomFloatingAppBox(),
          ),
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
                        '            Confirm Locations            ',
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
        Positioned(
          top: 60,
          right: isArabic() ? 16 : SizeConfig.defaultSize! * 32,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
                backgroundColor: const Color(0xff8AD4B5),
                onPressed: () {
                  widget.scaffoldKey.currentState!.openDrawer();
                },
                title: const Icon(
                  Icons.menu,
                  color: Colors.black,
                )),
          ),
        ),
        Positioned(
          top: 60,
          left: isArabic() ? 16 : SizeConfig.defaultSize! * 32,
          child: CustomButton(
              backgroundColor: Colors.white,
              onPressed: () {},
              title: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              )),
        ),
      ],
    );
  }
}

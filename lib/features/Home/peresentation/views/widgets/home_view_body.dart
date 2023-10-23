import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:ride_glide/constants.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';

import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Place_details_cubit/place_details_cubit_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/views/home_view.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_bottomBar.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_floatin_app_box.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({Key? key}) : super(key: key);

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
          onMapCreated: (controller) {
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
          mapType: MapType.terrain,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomButton(
                backgroundColor: const Color(0xff8AD4B5),
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                title: const Icon(
                  Icons.menu,
                  color: Colors.black,
                )),
          ),
        ),
        Positioned(
          top: 60,
          right: 15,
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

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = Hive.box<UserModel>(kUserBox).values.first;
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(82),
          topRight: Radius.circular(82),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: CustomAppBar(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                decoration: ShapeDecoration(
                  shape: OvalBorder(
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  color: const Color(0xffD0D0D0),
                ),
                height: 90,
                width: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: user.imageUrl!,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                '${user.name}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff5A5A5A)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  '${user.email}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            CustomDrawerElement(
              icon: Assets.HistoryIcon,
              title: 'History',
              onTap: () {},
            ),
            CustomDrawerElement(
              icon: Assets.ComplainIcon,
              title: 'Complain',
              onTap: () {},
            ),
            CustomDrawerElement(
              icon: Assets.RefferalIcon,
              title: 'Referral',
              onTap: () {},
            ),
            CustomDrawerElement(
              icon: Assets.AboutUsIcon,
              title: 'About Us',
              onTap: () {},
            ),
            CustomDrawerElement(
              icon: Assets.SettingsIcon,
              title: 'Settings',
              onTap: () {},
            ),
            CustomDrawerElement(
              icon: Assets.HelpIcon,
              title: 'Help and Support',
              onTap: () {},
            ),
            CustomDrawerElement(
              icon: Assets.LogOutIcon,
              title: 'Log Out',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawerElement extends StatelessWidget {
  const CustomDrawerElement({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });
  final String title;
  final String icon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            icon,
            scale: 0.7,
          ),
          title: Text(title),
          titleTextStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontWeight: FontWeight.bold),
          onTap: onTap,
        ),
        const Divider(
          thickness: 1.5,
        )
      ],
    );
  }
}

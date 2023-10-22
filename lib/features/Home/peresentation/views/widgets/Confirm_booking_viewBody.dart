import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ride_glide/constants.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/features/Home/data/models/driver_Model.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_destination_cubit/pick_destination_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Pick_location_cubit/pick_location_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Ride_requests_cubit/ride_requests_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/manager/payment_cubit/payment_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_LocationDestinationColumn.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/confirm_booking_custom_card.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_payment_Method_card.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';

class ConfirmBookingViewBody extends StatelessWidget {
  const ConfirmBookingViewBody({super.key, required this.driver});
  final DriverModel driver;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60, bottom: 10),
              child: CustomAppBar(),
            ),
            Center(
              child: Text(
                'Request for rent',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff5A5A5A)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const LocationDestinationColumn(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomConfirmBookingCard(driver: driver),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Charge',
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total =  ${(travelDistance * 8).toStringAsFixed(2)}  EGP',
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              'Select payment method',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500, color: const Color(0xff5A5A5A)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocListener<PaymentCubit, PaymentState>(
                listener: (context, state) async {
                  if (state is PaymentSuccess) {
                    Box<UserModel> userBox = Hive.box<UserModel>(kUserBox);

                    UserModel user = userBox.values.first;

                    await BlocProvider.of<RideRequestsCubit>(context)
                        .requestNewRide(
                            locationAddress: PickLocationCubit
                                    .location?.result?.formattedAddress ??
                                'err',
                            destinationAddress: PickDestinationCubit
                                    .destination?.result?.formattedAddress ??
                                'err',
                            lat: PickLocationCubit
                                    .location?.result?.geometry?.location?.lat
                                    ?.toDouble() ??
                                0,
                            lng: PickLocationCubit
                                    .location?.result?.geometry?.location?.lng
                                    ?.toDouble() ??
                                0,
                            time: 'Now',
                            ridePrice: (travelDistance * 10).toString(),
                            userUid: auth.currentUser?.uid ?? 'err',
                            clientName: user.fullName ?? user.name ?? 'err',
                            clienImageUrl: user.imageUrl ?? 'err',
                            paymentMethod: 'Payed with Visa',
                            driverUID: driver.uID!);
                    GoRouter.of(context).pushReplacement(
                        AppRouter.kPaymentSuccessView,
                        extra: driver);
                  } else if (state is PaymentFaluire) {
                    snackBar(context, state.errMessage);
                    debugPrint(
                        'THIS IS THE ERROR ()()(==== )==== ${state.errMessage}');
                  } else if (state is PaymentLoading) {
                    snackBar(context, 'wait a moment');
                  }
                },
                child: CustomPaymentMethodCard(
                    onTap: () async {
                      await BlocProvider.of<PaymentCubit>(context).makePayment(
                          amount: (travelDistance * 10).toInt(),
                          currency: 'EGP');
                    },
                    icon: Assets.VisaIcon,
                    text: 'Pay with your visa card'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomPaymentMethodCard(
                  onTap: () async {
                    var userBox = Hive.box<UserModel>(kUserBox);

                    UserModel user = userBox.values.first;

                    await BlocProvider.of<RideRequestsCubit>(context)
                        .requestNewRide(
                            locationAddress: PickLocationCubit
                                    .location?.result?.formattedAddress ??
                                'err',
                            destinationAddress: PickDestinationCubit
                                    .destination?.result?.formattedAddress ??
                                'err',
                            lat: PickLocationCubit
                                    .location?.result?.geometry?.location?.lat
                                    ?.toDouble() ??
                                0,
                            lng: PickLocationCubit
                                    .location?.result?.geometry?.location?.lng
                                    ?.toDouble() ??
                                0,
                            time: 'Now',
                            ridePrice: (travelDistance * 10).toString(),
                            userUid: auth.currentUser?.uid ?? 'err',
                            clientName: user.fullName ?? user.name ?? 'err',
                            clienImageUrl: user.imageUrl ?? 'err',
                            paymentMethod: 'Payed with Visa',
                            driverUID: driver.uID!);
                    GoRouter.of(context).pushReplacement(
                        AppRouter.kPaymentSuccessView,
                        extra: driver);
                  },
                  icon: Assets.CashIcon,
                  text: 'Pay Cash'),
            ),
          ],
        ),
      ),
    );
  }
}

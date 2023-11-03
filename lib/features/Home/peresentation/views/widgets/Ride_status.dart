import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:ride_glide/constants.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo_implementation.dart';
import 'package:ride_glide/features/auth/data/AuthRepo/authRepoImpl.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_button.dart';

class RideStatus extends StatelessWidget {
  const RideStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: StreamBuilder<bool?>(
            stream: HomeRepoImpl.listenForRideConfirmation(
                rideId: Hive.box<UserModel>(kUserBox).values.first.uId!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Loading indicator
              }

              final rideConfirmed = snapshot.data;

              if (rideConfirmed == null) {
                return const Text('Please Wait ...');
              } else if (rideConfirmed) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Ride Confirmed Click Here to go to Home Page',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomButton(
                        onPressed: () async {
                          GoRouter.of(context).pop();
                          GoRouter.of(context).pop();
                          GoRouter.of(context).pop();
                          await HomeRepoImpl.deleteTHeRide(
                              uid: auth.currentUser!.uid);
                        },
                        title: const Text('Start Ride'),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Ride has been cancled Click Here to go to Home Page',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomButton(
                        onPressed: () {
                          GoRouter.of(context).pop();
                          GoRouter.of(context).pop();
                          GoRouter.of(context).pop();
                        },
                        title: const Text('Cancel Ride'),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

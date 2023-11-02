import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/features/Home/peresentation/manager/OnlineDrivers_cubit/online_drivers_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/custom_avaliable_cars_card.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';
import 'package:ride_glide/generated/l10n.dart';

class AvaialbeCarsViewBody extends StatelessWidget {
  const AvaialbeCarsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnlineDriversCubit, OnlineDriversState>(
      builder: (context, state) {
        if (state is OnlineDriversSuccess) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 60, bottom: 30),
                      child: CustomAppBar(),
                    ),
                    Center(
                      child: Text(
                        S.of(context).AvailableCarsForRide,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff5A5A5A)),
                      ),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: Center(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.onlineDrivers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: CustomAvaliableDriversCard(
                          onPressed: () {
                            GoRouter.of(context).push(
                                AppRouter.kConfirmBookingView,
                                extra: state.onlineDrivers[index]);
                          },
                          driver: state.onlineDrivers[index],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          );
        } else if (state is OnlineDriversFaluire) {
          return Center(
            child: Text(state.erMessage),
          );
        } else if (state is OnlineDriversLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

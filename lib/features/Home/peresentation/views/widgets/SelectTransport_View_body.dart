import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/core/utils/methods.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/features/Home/peresentation/manager/OnlineDrivers_cubit/online_drivers_cubit.dart';
import 'package:ride_glide/features/Home/peresentation/views/widgets/Custom_transport_type_card.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';

class SelectTransportViewBody extends StatelessWidget {
  const SelectTransportViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 60, bottom: 30),
          child: CustomAppBar(),
        ),
        Center(
          child: Text(
            'Select your transport',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500, color: const Color(0xff5A5A5A)),
          ),
        ),
        SizedBox(
          height: SizeConfig.screenhieght! * 0.7,
          width: SizeConfig.screenwidth! * 0.7,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 20, crossAxisCount: 2, mainAxisSpacing: 20),
            children: [
              BlocListener<OnlineDriversCubit, OnlineDriversState>(
                listener: (context, state) {
                  if (state is OnlineDriversSuccess) {
                    GoRouter.of(context).push(AppRouter.kAvaialbeCarsView);
                  }
                  if (state is OnlineDriversFaluire) {
                    snackBar(context, state.erMessage);
                  }
                },
                child: CustomTansportTypeCard(
                  icon: Assets.CarIcon,
                  title: 'Car',
                  onTap: () async {
                    await BlocProvider.of<OnlineDriversCubit>(context)
                        .checkForOnlineDrivers();
                  },
                ),
              ),
              const CustomTansportTypeCard(
                  icon: Assets.BikeIcon, title: 'Bike'),
              const CustomTansportTypeCard(
                  icon: Assets.CycleIcon, title: 'Cycle'),
              const CustomTansportTypeCard(
                  icon: Assets.TaxiIcon, title: 'Taxi'),
            ],
          ),
        )
      ],
    );
  }
}

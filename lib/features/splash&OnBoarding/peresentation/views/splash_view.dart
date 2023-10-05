import 'package:flutter/material.dart';

import '../../../../core/utils/size_config.dart';
import 'widgets/splash_view_body.dart';

class SplashVIew extends StatelessWidget {
  const SplashVIew({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}

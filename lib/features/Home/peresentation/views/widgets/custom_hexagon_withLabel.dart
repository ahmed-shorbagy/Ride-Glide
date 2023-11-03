import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/core/utils/size_config.dart';
import 'package:ride_glide/generated/l10n.dart';

class CustomhexagonWithLabel extends StatelessWidget {
  const CustomhexagonWithLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HexagonWidget.pointy(
          cornerRadius: 8,
          color: const Color(0xff08B783),
          width: 100,
          child: Image.asset(
            Assets.WalletIcon,
            scale: 0.6,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: SizeConfig.defaultSize! * 0.7,
        ),
        Text(
          S.of(context).bottomBarWallet,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:ride_glide/features/auth/data/models/user_model.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_phoneField.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/custom_text_search_field.dart';
import 'package:ride_glide/generated/l10n.dart';

class CustomProfileData extends StatelessWidget {
  const CustomProfileData({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Container(
              decoration: ShapeDecoration(
                shape: OvalBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                color: const Color(0xffD0D0D0),
              ),
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: user.imageUrl!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              '${user.name}',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold, color: const Color(0xff5A5A5A)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CustomTextField(
            onChanged: (value) {
              user.email = value;
            },
            hintText: '',
            initialValue: user.email ?? '',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CustomTextField(
            onChanged: (value) {
              user.email = value;
            },
            hintText: '',
            initialValue: user.adress ?? '',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CustomPhoneField(
            autoValidateMode: AutovalidateMode.always,
            onChanged: (value) {},
            initialValue:
                PhoneNumber(isoCode: IsoCode.EG, nsn: user.phone.substring(3)),
          ),
        ),
      ],
    );
  }
}

class CustomProfileHeadLine extends StatelessWidget {
  const CustomProfileHeadLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).Profile,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

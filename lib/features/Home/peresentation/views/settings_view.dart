import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_glide/core/utils/App_router.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';
import 'package:ride_glide/generated/l10n.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60, bottom: 30),
              child: CustomAppBar(),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomSettingsElement(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kChangePasswordView);
                },
                title: S.of(context).ChangePassword,
                icon: Icons.arrow_forward_ios,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomSettingsElement(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kChangeLanguageView);
                },
                title: S.of(context).ChangeLanguage,
                icon: Icons.arrow_forward_ios,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomSettingsElement(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kPrivacyPolicyView);
                },
                title: S.of(context).PrivacyPolicy,
                icon: Icons.arrow_forward_ios,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomSettingsElement(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kChangeThemeView);
                },
                title: S.of(context).ChangeTheme,
                icon: Icons.arrow_forward_ios,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomSettingsElement(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kDeleteAccountView);
                },
                title: S.of(context).DeleteAccount,
                icon: Icons.arrow_forward_ios,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSettingsElement extends StatelessWidget {
  const CustomSettingsElement({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 362,
        height: 61,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.50, color: Color(0xFF08B783)),
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3D000000),
              blurRadius: 1,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Icon(icon)
            ],
          ),
        ),
      ),
    );
  }
}

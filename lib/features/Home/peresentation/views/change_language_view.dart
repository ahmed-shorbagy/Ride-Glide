import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_glide/core/utils/App_images.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Language_cubit/language_cubit.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';

class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({super.key});

  @override
  State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

bool englishSelected = false;
bool arabicSelected = false;

class _ChangeLanguageViewState extends State<ChangeLanguageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60, bottom: 30),
            child: CustomAppBar(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomLanguageElement(
              isSelected: englishSelected,
              title: 'English',
              image: Assets.EnglishFlag,
              onTap: () {
                BlocProvider.of<LanguageCubit>(context)
                    .changeLanguage(const Locale('en'));
                setState(() {
                  englishSelected = true;
                  arabicSelected = false;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomLanguageElement(
              isSelected: arabicSelected,
              title: 'Arabic',
              image: Assets.ArabicFlag,
              onTap: () {
                BlocProvider.of<LanguageCubit>(context)
                    .changeLanguage(const Locale('ar'));
                setState(() {
                  englishSelected = false;
                  arabicSelected = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomLanguageElement extends StatelessWidget {
  const CustomLanguageElement({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    required this.isSelected,
  });
  final String title;
  final String image;
  final void Function() onTap;
  final bool isSelected;
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(image),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Checkbox(
                visualDensity: VisualDensity.comfortable,
                fillColor:
                    MaterialStatePropertyAll(Colors.grey.withOpacity(0.4)),
                checkColor: Theme.of(context).primaryColor,
                shape: const CircleBorder(
                    side: BorderSide(width: 2, color: Colors.green)),
                value: isSelected,
                onChanged: (value) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

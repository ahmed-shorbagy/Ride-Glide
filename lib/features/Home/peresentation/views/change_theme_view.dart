import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_glide/features/Home/peresentation/manager/Theme_provider/Theme_provider.dart';
import 'package:ride_glide/features/auth/peresentation/views/widgets/Custom_appBar.dart';

class ChangeThemeView extends StatefulWidget {
  const ChangeThemeView({super.key});

  @override
  State<ChangeThemeView> createState() => _ChangeThemeViewState();
}

bool lightSelected = false;
bool darkSelected = false;

class _ChangeThemeViewState extends State<ChangeThemeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Padding(
          padding: EdgeInsets.only(top: 60, bottom: 30),
          child: CustomAppBar(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomThemeElement(
            isSelected: lightSelected,
            title: 'Light',
            icon: Icons.light_mode,
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false)
                  .setThemeMode(ThemeMode.light);
              setState(() {
                lightSelected = true;
                darkSelected = false;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomThemeElement(
            isSelected: darkSelected,
            title: 'Dark',
            icon: Icons.dark_mode,
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false)
                  .setThemeMode(ThemeMode.dark);
              setState(() {
                lightSelected = false;
                darkSelected = true;
              });
            },
          ),
        ),
      ]),
    );
  }
}

class CustomThemeElement extends StatelessWidget {
  const CustomThemeElement({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });
  final String title;
  final IconData icon;
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
              Icon(icon),
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

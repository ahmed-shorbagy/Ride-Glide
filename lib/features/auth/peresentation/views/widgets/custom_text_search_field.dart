import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.onChanged,
      required this.hintText,
      this.suffixIcon,
      this.obscuretext,
      this.textEditingController,
      this.onTap,
      this.initialValue});

  final void Function(String) onChanged;
  final TextEditingController? textEditingController;

  final String hintText;
  final Widget? suffixIcon;
  final bool? obscuretext;
  final void Function()? onTap;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onTap: onTap,
      controller: textEditingController,
      obscureText: obscuretext ?? false,
      style: Theme.of(context).textTheme.titleMedium,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'This Field is required';
        } else {
          return null;
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          suffixIcon: suffixIcon ?? const SizedBox(),
          label: Text(hintText),
          labelStyle: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.grey.withOpacity(0.6)),
          focusColor: Theme.of(context).primaryColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          suffixIconColor: Colors.white.withOpacity(.8),
          enabledBorder: customBoroder(Colors.grey.withOpacity(0.6)),
          focusedBorder: customBoroder(Theme.of(context).primaryColor),
          disabledBorder: customBoroder(Colors.grey.withOpacity(0.6)),
          border: customBoroder(Colors.grey.withOpacity(0.6))),
    );
  }

  OutlineInputBorder customBoroder(Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 1.5,
        ));
  }
}

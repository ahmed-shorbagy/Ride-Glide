import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class CustomDropdownTextField extends StatelessWidget {
  const CustomDropdownTextField(
      {super.key, required this.onChanged, required this.hintText});

  final void Function(dynamic) onChanged;

  final String hintText;
  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      onChanged: onChanged,
      initialValue: 'Gender',
      dropDownList: const [
        DropDownValueModel(name: 'Male', value: "Male"),
        DropDownValueModel(
          name: 'Female',
          value: "Female",
        )
      ],
      textStyle: Theme.of(context).textTheme.titleMedium,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter a value';
        } else {
          return null;
        }
      },
      textFieldDecoration: InputDecoration(
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

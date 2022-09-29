import 'package:e_markety_client/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.label,
    this.icon,
  }) : super(key: key);

  final String label;
  final Icon? icon;

  final outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        filled: true,
        fillColor: kBackgroundColor,
        // labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: icon,
        ),
      ),
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      obscureText: label == 'Senha',
      obscuringCharacter: '*',
    );
  }
}

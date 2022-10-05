import 'package:flutter/material.dart';

import '../theme/constants.dart';

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
        contentPadding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        filled: true,
        fillColor: kBackgroundColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: icon,
        ),
      ),
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      obscureText: label == 'Senha',
      obscuringCharacter: '*',
    );
  }
}

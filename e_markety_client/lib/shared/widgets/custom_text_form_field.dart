import 'package:flutter/material.dart';

import '../theme/constants.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required this.label,
    this.icon,
    this.onTapSuffix,
    this.obscureText = false,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  final String label;
  final Icon? icon;
  final void Function()? onTapSuffix;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.white),
  );

  final FocusNode _focusNode = FocusNode();
  double _labelTopPadding = 0;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _labelTopPadding = _focusNode.hasFocus ? 30 : 0);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(24, 18, 24, 16),
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        filled: true,
        fillColor: kBackgroundColor,
        label: Padding(
          padding: EdgeInsets.only(top: _labelTopPadding),
          child: Text(
            widget.label,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        suffixIcon: InkWell(
          onTap: widget.onTapSuffix,
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: widget.icon,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      obscureText: widget.obscureText,
      obscuringCharacter: '*',
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }
}

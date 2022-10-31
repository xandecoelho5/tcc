import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';

class DropdownWithLabel<T> extends StatelessWidget {
  const DropdownWithLabel({
    Key? key,
    required this.label,
    required this.items,
    this.onSaved,
    this.onValidate,
    this.data,
  }) : super(key: key);

  final String label;
  final List<T> items;
  final void Function(T?)? onSaved;
  final String? Function(T?)? onValidate;
  final T? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: kLabelStyle),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          decoration: kTextInputDecoration,
          menuMaxHeight: 350,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
              .toList(),
          value: data,
          onChanged: (value) {},
          onSaved: onSaved,
          validator: onValidate,
        ),
      ],
    );
  }
}

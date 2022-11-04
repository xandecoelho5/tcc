import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';

class DropdownWithLabel<T> extends StatelessWidget {
  const DropdownWithLabel({
    Key? key,
    required this.label,
    required this.items,
    this.data,
    this.onSaved,
    this.onValidate,
    this.onChanged,
    this.backgroundColor,
  }) : super(key: key);

  final String label;
  final List<T> items;
  final T? data;
  final void Function(T?)? onSaved;
  final String? Function(T?)? onValidate;
  final void Function(T?)? onChanged;
  final Color? backgroundColor;

  List<DropdownMenuItem<T>> _buildItems() {
    return items
        .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: kLabelStyle),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButtonFormField<T>(
            decoration: kTextInputDecoration,
            menuMaxHeight: 350,
            items: _buildItems(),
            value: data,
            onChanged: onChanged ?? (_) {},
            onSaved: onSaved,
            validator: onValidate,
          ),
        )
      ],
    );
  }
}

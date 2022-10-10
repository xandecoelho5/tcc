import 'package:flutter/material.dart';

enum Tag {
  home('Home', Icons.house_outlined),
  office('Office', Icons.work_outline),
  other('Other', Icons.location_on_outlined);

  const Tag(this.label, this.icon);

  final IconData icon;
  final String label;
}

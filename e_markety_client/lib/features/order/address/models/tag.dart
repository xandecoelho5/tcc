import 'package:flutter/material.dart';

enum Tag {
  home('Casa', Icons.house_outlined),
  office('Trabalho', Icons.work_outline),
  other('Outros', Icons.location_on_outlined);

  const Tag(this.label, this.icon);

  final IconData icon;
  final String label;

  static Tag fromString(String tag) {
    switch (tag.toUpperCase()) {
      case 'CASA':
        return Tag.home;
      case 'TRABALHO':
        return Tag.office;
      default:
        return Tag.other;
    }
  }
}

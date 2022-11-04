import 'package:flutter/material.dart';

enum Tag {
  home('Casa', Icons.house_outlined),
  office('Trabalho', Icons.work_outline),
  other('Outro', Icons.location_on_outlined);

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

  String toRemoteName() {
    switch (this) {
      case Tag.home:
        return 'CASA';
      case Tag.office:
        return 'TRABALHO';
      case Tag.other:
        return 'OUTRO';
    }
  }

  @override
  String toString() => label;
}

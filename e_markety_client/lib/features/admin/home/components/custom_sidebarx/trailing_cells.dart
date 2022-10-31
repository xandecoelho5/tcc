import 'package:flutter/material.dart';

import 'custom_sidebarx_item.dart';

class TrailingCells extends StatefulWidget {
  const TrailingCells({Key? key, required this.items}) : super(key: key);

  final List<SidebarSubItem> items;

  @override
  State<TrailingCells> createState() => _TrailingCellsState();
}

class _TrailingCellsState extends State<TrailingCells> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.items.length,
        (index) => _TrailingCell(
          item: widget.items[index],
          selected: _selectedIndex == index,
          onTap: () => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}

class _TrailingCell extends StatelessWidget {
  const _TrailingCell({
    Key? key,
    required this.item,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  final SidebarSubItem item;
  final bool selected;
  final VoidCallback onTap;

  TextStyle get textStyle => selected
      ? const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 0.3,
        )
      : const TextStyle(
          color: Colors.white,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
        item.onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        color: Colors.white.withOpacity(0.25),
        child: Text(item.label, style: textStyle),
      ),
    );
  }
}

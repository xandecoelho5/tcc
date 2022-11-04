import 'dart:math';

import 'package:e_markety_client/features/admin/home/components/custom_sidebarx/trailing_cells.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import 'custom_sidebarx_item.dart';

class CustomSidebarXCell extends StatefulWidget {
  const CustomSidebarXCell({
    Key? key,
    required this.item,
    required this.extended,
    required this.selected,
    required this.theme,
    required this.onTap,
    required this.animationController,
  }) : super(key: key);

  final bool extended;
  final bool selected;
  final CustomSidebarXItem item;
  final SidebarXTheme theme;
  final VoidCallback onTap;
  final AnimationController animationController;

  @override
  State<CustomSidebarXCell> createState() => _CustomSidebarXCellState();
}

class _CustomSidebarXCellState extends State<CustomSidebarXCell> {
  late Animation<double> _animation;
  var _hovered = false;
  var _expanded = false;

  @override
  void initState() {
    super.initState();
    _animation = CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_expanded && !widget.selected) {
      _expanded = false;
    }
    final theme = widget.theme;
    final iconTheme =
        widget.selected ? theme.selectedIconTheme : theme.iconTheme;
    final textStyle =
        widget.selected ? theme.selectedTextStyle : theme.textStyle;
    final decoration =
        widget.selected ? theme.selectedItemDecoration : theme.itemDecoration;
    var margin = widget.selected ? theme.selectedItemMargin : theme.itemMargin;
    margin = margin ?? const EdgeInsets.all(4);
    var padding =
        widget.selected ? theme.selectedItemPadding : theme.itemPadding;
    padding = padding ?? const EdgeInsets.all(8);
    final textPadding =
        widget.selected ? theme.selectedItemTextPadding : theme.itemTextPadding;

    return MouseRegion(
      onEnter: (_) => _onEnteredCellZone(),
      onExit: (_) => _onExitCellZone(),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.onTap();
          if (widget.item.trailing) setState(() => _expanded = !_expanded);
        },
        child: Container(
          decoration: decoration?.copyWith(
            color: _hovered && !widget.selected ? theme.hoverColor : null,
          ),
          padding: widget.item.trailing && widget.selected
              ? EdgeInsets.zero
              : padding,
          margin: margin,
          child: Column(
            children: [
              Padding(
                padding: !widget.item.trailing ||
                        widget.item.trailing && !widget.selected
                    ? EdgeInsets.zero
                    : padding,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: widget.extended
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, _) {
                              final value =
                                  ((1 - _animation.value) * 6).toInt();
                              if (value <= 0) {
                                return const SizedBox();
                              }
                              return Spacer(flex: value);
                            },
                          ),
                          if (widget.item.icon != null)
                            _Icon(item: widget.item, iconTheme: iconTheme)
                          else if (widget.item.iconWidget != null)
                            widget.item.iconWidget!,
                          Flexible(
                            flex: 6,
                            child: FadeTransition(
                              opacity: _animation,
                              child: Padding(
                                padding: textPadding ?? EdgeInsets.zero,
                                child: Text(
                                  widget.item.label ?? '',
                                  style: textStyle,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.item.trailing)
                      _expanded && widget.selected
                          ? Icon(Icons.expand_more, color: textStyle?.color)
                          : Transform.rotate(
                              angle: 270 * pi / 180,
                              child: Icon(
                                Icons.expand_more,
                                color: textStyle?.color,
                              ),
                            ),
                  ],
                ),
              ),
              if (_expanded && widget.selected)
                TrailingCells(items: widget.item.trailingItems!),
            ],
          ),
        ),
      ),
    );
  }

  void _onEnteredCellZone() {
    setState(() => _hovered = true);
  }

  void _onExitCellZone() {
    setState(() => _hovered = false);
  }
}

class _Icon extends StatelessWidget {
  const _Icon({
    Key? key,
    required this.item,
    required this.iconTheme,
  }) : super(key: key);

  final SidebarXItem item;
  final IconThemeData? iconTheme;

  @override
  Widget build(BuildContext context) {
    return Icon(
      item.icon,
      color: iconTheme?.color,
      size: iconTheme?.size,
    );
  }
}

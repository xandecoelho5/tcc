import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

class InformationContainer extends StatefulWidget {
  const InformationContainer({
    Key? key,
    required this.title,
    this.titleColor,
    this.child,
    this.icon,
    this.onIconTapped,
    this.modifiable = false,
    this.expanded = false,
    this.elevation,
  }) : super(key: key);

  final String title;
  final Color? titleColor;
  final Widget? child;
  final IconData? icon;
  final void Function()? onIconTapped;
  final bool modifiable;
  final bool expanded;
  final double? elevation;

  @override
  State<InformationContainer> createState() => _InformationContainerState();
}

class _InformationContainerState extends State<InformationContainer> {
  late bool _expanded = widget.expanded;

  @override
  Widget build(BuildContext context) {
    final bool expandable = (widget.child != null &&
        ((widget.modifiable && _expanded) || !widget.modifiable));

    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: widget.elevation ?? (expandable ? 1 : 0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 16, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: expandable
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                  : BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.titleColor ?? kBasicDarkColor,
                  ),
                ),
                if (widget.icon != null)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => setState(() => _expanded = !_expanded),
                      borderRadius: BorderRadius.circular(50),
                      child: Icon(widget.icon, size: 30),
                    ),
                  ),
              ],
            ),
          ),
          if (expandable)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              decoration: const BoxDecoration(
                color: kScaffoldColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: widget.child,
            ),
        ],
      ),
    );
  }
}

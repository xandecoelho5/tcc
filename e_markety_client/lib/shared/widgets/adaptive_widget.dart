import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../environment/platform.dart';

class AdaptiveWidget extends StatelessWidget {
  const AdaptiveWidget({
    Key? key,
    required this.child,
    this.height,
  }) : super(key: key);

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (Modular.get<AppPlatform>().isMobile) return child;

    return Align(
      child: Container(
        width: 450,
        height: height ?? 420,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

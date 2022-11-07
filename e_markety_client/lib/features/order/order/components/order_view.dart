import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/filled_button.dart';

class OrderView extends StatelessWidget {
  const OrderView({
    Key? key,
    required this.title,
    required this.mainMessage,
    required this.subMessage,
    required this.buttonText,
    required this.backgroundColor,
    required this.buttonColor,
    this.onButtonPressed,
  }) : super(key: key);

  final String title;
  final String mainMessage;
  final String subMessage;
  final String buttonText;
  final Color backgroundColor;
  final Color buttonColor;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        context,
        title: title,
        showAction: false,
        onLeadingTap: () =>
            Modular.to.pushNamedAndRemoveUntil('/', (_) => false),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Spacer(),
                    const Icon(
                      Icons.shopping_bag_outlined,
                      size: 150,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    Text(
                      mainMessage,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    Text(
                      subMessage,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FilledButton(
                text: buttonText,
                color: buttonColor,
                onPressed: onButtonPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

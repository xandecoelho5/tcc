import 'package:flutter/material.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/filled_button.dart';

class OrderDecline extends StatelessWidget {
  const OrderDecline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Order Decline'),
      body: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: kBasicDarkColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 150,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 48),
                  const Text(
                    'Sorry, Your order has failed',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    """
Sorry, somethings went wrong.
Please try again to continue your order.
                    """,
                    style: TextStyle(
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
            const Spacer(),
            FilledButton(
              text: 'Track Order',
              color: kPrimaryColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

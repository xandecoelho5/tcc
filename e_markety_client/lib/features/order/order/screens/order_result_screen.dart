import 'package:flutter/material.dart';

import '../components/order_decline.dart';
import '../components/order_success.dart';

class OrderResultScreen extends StatelessWidget {
  const OrderResultScreen({Key? key, required this.isSuccess})
      : super(key: key);

  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    if (isSuccess) {
      return const OrderSuccess();
    }

    return const OrderDecline();
  }
}

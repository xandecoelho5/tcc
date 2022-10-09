import 'package:e_markety_client/features/order/components/order_details.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../shared/mocks/mocks.dart';
import '../models/order.dart';

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({Key? key}) : super(key: key);

  final List<Order> orders = ordersMock;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'My Orders'),
      // mudar para FutureBuilder depois
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemBuilder: (ctx, i) => OrderDetails(order: orders[i]),
        separatorBuilder: (ctx, i) => const SizedBox(height: 20),
        itemCount: orders.length,
      ),
    );
  }
}

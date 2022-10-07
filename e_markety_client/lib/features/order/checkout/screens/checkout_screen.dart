import 'package:e_markety_client/features/order/address/components/address_info.dart';
import 'package:e_markety_client/features/order/components/total_container.dart';
import 'package:e_markety_client/features/order/models/delivery_tipe.dart';
import 'package:e_markety_client/features/order/models/order.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/filled_button.dart';
import '../components/information_container.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key, required this.order}) : super(key: key);

  final Order order;

  _orderId() {
    const style = TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Order ID', style: style),
          Text('#OD${order.id}', style: style),
        ],
      ),
    );
  }

  _deliveryAddress() {
    return InformationContainer(
      title: 'Delivery Address',
      icon: Icons.more_horiz,
      child: AddressInfo(address: order.deliveryAddress!),
    );
  }

  _deliveryTimeSettings() {
    return InformationContainer(
      title: 'Delivery Time Settings',
      child: Column(
        children: [
          // titleColor: Colors.grey.shade700,
          InformationContainer(
            title: 'Time Slot',
            icon: Icons.keyboard_arrow_down,
            titleColor: Colors.grey.shade700,
            modifiable: true,
            child: const Text('9:00 AM - 17:00 PM'),
          ),
          const SizedBox(height: 16),
          InformationContainer(
            title: 'Jan 26, 2021',
            icon: Icons.calendar_month,
            titleColor: Colors.grey.shade700,
          ),
        ],
      ),
    );
  }

  List<Widget> _deliveryRelated() {
    return [
      _deliveryAddress(),
      const SizedBox(height: 20),
      _deliveryTimeSettings(),
      const SizedBox(height: 20),
    ];
  }

  _orderBill() {
    return InformationContainer(
      title: 'Order Bill',
      child: TotalContainer(order: order, showDiscount: true),
    );
  }

  _notes() {
    final border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
    );

    return InformationContainer(
      title: 'Notes',
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Type Something you want here...',
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.bold,
          ),
          border: border,
          enabledBorder: border,
          focusedBorder: border,
        ),
        maxLines: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Checkout'),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    _orderId(),
                    const SizedBox(height: 20),
                    if (order.deliveryType == DeliveryType.delivery)
                      ..._deliveryRelated(),
                    _orderBill(),
                    const SizedBox(height: 20),
                    _notes(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: FilledButton(
                text: 'Place Order',
                color: kSecondaryColor,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

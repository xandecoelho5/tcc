import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:e_markety_client/shared/widgets/filled_button.dart';
import 'package:flutter/material.dart';

import '../../../../shared/mocks/mocks.dart';
import '../components/address_list.dart';

class DeliveryAddressScreen extends StatelessWidget {
  const DeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Delivery Address'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shipping To',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Expanded(
                    child: AddressList(
                      addresses: addressMock,
                      isShopping: true,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: FilledButton(
                text: 'Delivery to This Address',
                color: kSecondaryColor,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

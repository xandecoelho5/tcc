import 'package:e_markety_client/shared/mocks/mocks.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';
import '../../../../shared/widgets/filled_button.dart';
import '../components/address_list.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'My Address'),
      body: Column(
        children: [
          const Expanded(
            flex: 8,
            child: AddressList(addresses: addressMock),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: FilledButton(
                text: 'Add New Address',
                onPressed: () {},
                color: kSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:e_markety_client/features/order/address/components/address_info.dart';
import 'package:e_markety_client/features/order/address/components/default_flag.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

import '../models/address.dart';

class AddressCartItem extends StatelessWidget {
  const AddressCartItem({Key? key, required this.address}) : super(key: key);

  final Address address;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 20, 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Radio(
                        value: 1,
                        groupValue: 1,
                        onChanged: (value) {},
                        activeColor: kPrimaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32, left: 8),
                      child: AddressInfo(address: address),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz),
                        iconSize: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 4,
            left: 20,
            child: DefaultFlag(),
          ),
        ],
      ),
    );
  }
}

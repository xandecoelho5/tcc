import 'package:e_markety_client/features/order/address/components/address_info.dart';
import 'package:e_markety_client/features/order/address/components/default_flag.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/address.dart';

class AddressCartItem extends StatelessWidget {
  const AddressCartItem({
    Key? key,
    required this.address,
    required this.index,
    this.selectedValue,
    this.onSelected,
  }) : super(key: key);

  final Address address;
  final int index;
  final int? selectedValue;
  final Function(int?)? onSelected;

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
                      child: Radio<int?>(
                        value: index,
                        groupValue: selectedValue,
                        onChanged: onSelected,
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
                    child: PopupMenuButton(
                      icon: const Icon(Icons.more_horiz),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 1,
                          child: Text('Editar'),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 1) {
                          Modular.to.pushNamed('/address');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (address.isDefault)
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

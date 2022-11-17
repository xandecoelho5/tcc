import 'package:e_markety_client/features/order/address/components/address_info.dart';
import 'package:e_markety_client/features/order/address/components/default_flag.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../blocs/address/address_bloc.dart';
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

  Future<void> _onEditAddress() async {
    await Modular.to.pushNamed('/address/edit/${address.id}');
    Modular.get<AddressBloc>().add(AddressGetAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
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
                      splashRadius: 1,
                      icon: const Icon(Icons.more_horiz),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 1,
                          child: Text('Editar'),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 1) _onEditAddress();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (address.isDefault)
            const Positioned(
              top: 0,
              left: 16,
              child: DefaultFlag(),
            ),
        ],
      ),
    );
  }
}

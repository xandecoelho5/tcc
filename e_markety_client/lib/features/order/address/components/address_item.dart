import 'package:e_markety_client/features/order/address/blocs/address/address_bloc.dart';
import 'package:e_markety_client/features/order/address/components/default_flag.dart';
import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/utils/dialog_utils.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({Key? key, required this.address}) : super(key: key);

  final Address address;

  void _onDeleteAddress() {
    DialogUtils.showDialog(
      'Excluir Endereço',
      'Deseja realmente excluir o endereço?',
      () => Modular.get<AddressBloc>().add(AddressDeleteByIdEvent(address.id!)),
    );
  }

  Future<void> _onEditAddress() async {
    await Modular.to.pushNamed('/address/edit/${address.id}');
    Modular.get<AddressBloc>().add(AddressGetAllEvent());
  }

  Material _addressContainer() {
    final color = address.isDefault ? kPrimaryColor : kSecondaryColor;

    Row row(icon, text) {
      return Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.white,
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
          ),
        ],
      );
    }

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(address.tag.icon, color: color, size: 50),
                    const SizedBox(width: 12),
                    Text(
                      address.tag.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                      icon: const Icon(Icons.more_horiz),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 0,
                          child: Text('Editar'),
                        ),
                        const PopupMenuItem(
                          value: 1,
                          child: Text('Deletar'),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 0) _onEditAddress();
                        if (value == 1) _onDeleteAddress();
                      },
                    ),
                  ],
                ),
              ),
              if (address.isDefault)
                const Positioned(
                  top: 0,
                  right: 16,
                  child: DefaultFlag(),
                ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50.withOpacity(0.95),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                row(Icons.person, address.name),
                const SizedBox(height: 8),
                row(Icons.phone, address.phone),
                const SizedBox(height: 8),
                row(Icons.location_on, address.fullAddress),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _addressContainer();
  }
}

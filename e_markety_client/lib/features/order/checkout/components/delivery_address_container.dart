import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../address/components/address_info.dart';
import '../../address/models/address.dart';
import 'information_container.dart';

class DeliveryAddressContainer extends StatelessWidget {
  const DeliveryAddressContainer({
    Key? key,
    required this.onAddressSelected,
    this.deliveryAddress,
  }) : super(key: key);

  final Function(Address) onAddressSelected;
  final Address? deliveryAddress;

  @override
  Widget build(BuildContext context) {
    return InformationContainer(
      title: 'Endereço de Entrega',
      popupMenuButton: PopupMenuButton(
        icon: const Icon(Icons.more_horiz),
        itemBuilder: (context) => [
          if (deliveryAddress != null)
            const PopupMenuItem(
              value: 1,
              child: Text('Alterar'),
            )
          else
            const PopupMenuItem(
              value: 2,
              child: Text('Adicionar'),
            ),
        ],
        onSelected: (value) async {
          if (value == 1) {
            final address =
                await Modular.to.pushNamed('/order/delivery-address');
            if (address != null) {
              onAddressSelected(address as Address);
            }
          }
          if (value == 2) {
            final address = await Modular.to.pushNamed(
              '/address/add',
              arguments: false,
            );
            if (address != null) {
              onAddressSelected(address as Address);
            }
          }
        },
      ),
      child: deliveryAddress != null
          ? AddressInfo(address: deliveryAddress!)
          : null,
    );
  }
}

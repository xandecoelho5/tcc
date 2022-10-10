import 'package:e_markety_client/features/order/address/components/address_item.dart';
import 'package:flutter/material.dart';

import '../models/address.dart';
import 'address_cart_item.dart';

class AddressList extends StatelessWidget {
  const AddressList({
    Key? key,
    required this.addresses,
    this.isShopping = false,
  }) : super(key: key);

  final List<Address> addresses;
  final bool isShopping;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: addresses.length,
      itemBuilder: (ctx, index) => isShopping
          ? AddressCartItem(address: addresses[index])
          : AddressItem(address: addresses[index]),
      separatorBuilder: (ctx, index) => const SizedBox(height: 24),
    );
  }
}

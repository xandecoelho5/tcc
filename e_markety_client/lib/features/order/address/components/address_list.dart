import 'package:flutter/material.dart';

import '../models/address.dart';
import 'address_item.dart';

class AddressList extends StatelessWidget {
  const AddressList({Key? key, required this.addresses}) : super(key: key);

  final List<Address> addresses;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: addresses.length,
      itemBuilder: (ctx, index) => AddressItem(address: addresses[index]),
      separatorBuilder: (ctx, index) => const SizedBox(height: 24),
    );
  }
}

import 'package:e_markety_client/features/order/address/components/address_item.dart';
import 'package:flutter/material.dart';

import '../models/address.dart';
import 'address_cart_item.dart';

class AddressList extends StatefulWidget {
  const AddressList({
    Key? key,
    required this.addresses,
    this.isShopping = false,
    this.onAddressSelected,
  }) : super(key: key);

  final List<Address> addresses;
  final bool isShopping;
  final Function(Address)? onAddressSelected;

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  late int? _radioValue = widget.addresses.indexWhere(
    (address) => address.isDefault,
  );

  void _onSelected(int? value) => setState(() {
        _radioValue = value;
        widget.onAddressSelected?.call(widget.addresses[_radioValue!]);
      });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: widget.addresses.length,
      itemBuilder: (ctx, index) => widget.isShopping
          ? AddressCartItem(
              address: widget.addresses[index],
              index: index,
              selectedValue: _radioValue,
              onSelected: _onSelected,
            )
          : AddressItem(address: widget.addresses[index]),
      separatorBuilder: (ctx, index) => const SizedBox(height: 12),
    );
  }
}

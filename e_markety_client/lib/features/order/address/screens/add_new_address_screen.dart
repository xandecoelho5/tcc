import 'package:e_markety_client/features/order/address/components/address_container.dart';
import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../blocs/address/address_bloc.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({Key? key, required this.getDefault})
      : super(key: key);

  final bool getDefault;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        title: 'Adicionar Novo Endereço',
        showAction: false,
      ),
      backgroundColor: Colors.white,
      body: AddressContainer(
        textButton: 'Adicionar',
        address: const Address.empty(),
        onSubmitAddress: (address) {
          Modular.get<AddressBloc>().add(
            AddressAddEvent(address, getDefault: getDefault),
          );
          Navigator.of(context).pop(address);
        },
      ),
    );
  }
}

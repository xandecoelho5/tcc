import 'package:e_markety_client/features/order/address/blocs/address/address_bloc.dart';
import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:e_markety_client/shared/widgets/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../components/address_list.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  Address? _address;

  void _onAddressSelected(Address address) {
    _address = address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        title: 'Endereço de Entrega',
        showAction: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enviando para',
                    style: kTitleLarge.copyWith(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<AddressBloc, AddressState>(
                      bloc: Modular.get<AddressBloc>()
                        ..add(AddressGetAllEvent()),
                      builder: (context, state) {
                        if (state is AddressLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is AddressListLoaded) {
                          _address ??=
                              state.addresses.firstWhere((e) => e.isDefault);
                          if (_address != null) {
                            _address = state.addresses
                                .firstWhere((e) => e.id == _address!.id);
                          }
                          return AddressList(
                            addresses: state.addresses,
                            isShopping: true,
                            onAddressSelected: _onAddressSelected,
                          );
                        }

                        if (state is AddressError) {
                          return Center(child: Text(state.message));
                        }

                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FilledButton(
                text: 'Entregar para este endereço',
                color: kSecondaryColor,
                onPressed: () => Modular.to.pop(_address),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

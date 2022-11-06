import 'package:e_markety_client/features/order/address/blocs/default_address/default_address_bloc.dart';
import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:e_markety_client/features/order/checkout/components/checkout_header.dart';
import 'package:e_markety_client/features/order/checkout/components/delivery_address_container.dart';
import 'package:e_markety_client/features/order/checkout/components/delivery_time_settings.dart';
import 'package:e_markety_client/features/order/checkout/components/delivery_type_switch.dart';
import 'package:e_markety_client/features/order/checkout/components/notes_container.dart';
import 'package:e_markety_client/features/order/order/models/delivery_tipe.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/widgets/filled_button.dart';
import '../../order/components/total_container.dart';
import '../../order/models/order.dart';
import '../components/information_container.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Order _order = widget.order;

  void _onDeliveryTypeChanged(bool value) {
    setState(() {
      _order = _order.copyWith(
        deliveryType: value ? DeliveryType.delivery : DeliveryType.pickup,
      );

      if (_order.deliveryType == DeliveryType.delivery &&
          _order.deliveryAddress == null) {
        // se Loaded é porque conseguiu pegar o endereço padrão, então seta
        final state = Modular.get<DefaultAddressBloc>().state;
        if (state is DefaultAddressLoaded) {
          _order = _order.copyWith(deliveryAddress: state.address);
        }
      }
    });
  }

  void _onAddressSelected(Address address) {
    setState(() => _order = _order.copyWith(deliveryAddress: address));
  }

  void _onNotesChange(String notes) {
    setState(() => _order = _order.copyWith(notes: notes));
  }

  List<Widget> _deliveryRelated() {
    return [
      DeliveryAddressContainer(
        onAddressSelected: _onAddressSelected,
        deliveryAddress: _order.deliveryAddress,
      ),
      const SizedBox(height: 20),
      const DeliveryTimeSettings(),
      const SizedBox(height: 20),
    ];
  }

  InformationContainer _orderBill() {
    return InformationContainer(
      title: 'Resumo da Conta',
      child: TotalContainer(order: _order, showDiscount: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        context,
        title: 'Checkout',
        showAction: false,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    CheckoutHeader(order: _order),
                    const SizedBox(height: 20),
                    DeliveryTypeSwitch(
                      deliveryType: _order.deliveryType,
                      onDeliveryTypeChanged: _onDeliveryTypeChanged,
                    ),
                    const SizedBox(height: 20),
                    if (_order.deliveryType == DeliveryType.delivery)
                      ..._deliveryRelated(),
                    _orderBill(),
                    const SizedBox(height: 20),
                    NotesContainer(onChange: _onNotesChange),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: FilledButton(
                text: 'Finalizar Pedido',
                color: kSecondaryColor,
                onPressed: () {
                  print(_order);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

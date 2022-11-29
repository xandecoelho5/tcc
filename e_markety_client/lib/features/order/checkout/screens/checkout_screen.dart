import 'package:e_markety_client/features/company/blocs/company_district/company_district_bloc.dart';
import 'package:e_markety_client/features/order/address/blocs/default_address/default_address_bloc.dart';
import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:e_markety_client/features/order/checkout/components/checkout_header.dart';
import 'package:e_markety_client/features/order/checkout/components/delivery_address_container.dart';
import 'package:e_markety_client/features/order/checkout/components/delivery_time_settings.dart';
import 'package:e_markety_client/features/order/checkout/components/delivery_type_switch.dart';
import 'package:e_markety_client/features/order/checkout/components/notes_container.dart';
import 'package:e_markety_client/features/order/order/models/delivery_tipe.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/utils/modular_utils.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/widgets/filled_button.dart';
import '../../order/blocs/order/order_bloc.dart';
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
  final orderBloc = Modular.get<OrderBloc>();
  late Order _order = widget.order.copyWith(
    total: widget.order.calculatedTotal,
  );

  void _onPlaceOrder() {
    if (_order.deliveryType == DeliveryType.delivery) {
      if (_order.deliveryAddress == null) {
        ModularUtils.showError('Selecione um endereço de entrega');
        return;
      }
      if (_order.deliveryTime == null) {
        ModularUtils.showError('Selecione um horário para entrega');
        return;
      }
    }
    orderBloc.add(OrderPlaceEvent(_order));
  }

  void _onDeliveryTypeChanged(bool value) {
    setState(() {
      _order = _order.copyWith(
        deliveryType: value ? DeliveryType.delivery : DeliveryType.pickup,
      );

      if (_order.deliveryType == DeliveryType.pickup) {
        _order = Order(
          id: _order.id,
          total: _order.calculatedTotal,
          createdAt: _order.createdAt,
          status: _order.status,
          deliveryType: DeliveryType.pickup,
          notes: _order.notes,
          items: _order.items,
          serviceCharge: _order.serviceCharge,
        );
      }

      if (_order.deliveryType == DeliveryType.delivery &&
          _order.deliveryAddress == null) {
        final state = Modular.get<DefaultAddressBloc>().state;
        if (state is DefaultAddressLoaded) {
          _onAddressSelected(state.address);
        }
      }
    });
  }

  void _onAddressSelected(Address address) {
    setState(() {
      _order = _order.copyWith(deliveryAddress: address);
      Modular.get<CompanyDistrictBloc>().add(
        CompanyDistrictCalculateTaxEvent(_order.deliveryAddress!.district!.id),
      );
    });
  }

  void _onNotesChange(String notes) {
    setState(() => _order = _order.copyWith(notes: notes));
  }

  void _onTimeChanged(DateTime? dateTime) {
    setState(() => _order = _order.copyWith(deliveryTime: dateTime));
  }

  void _onDistrictTaxChanged(double tax) {
    setState(() {
      _order = _order.copyWith(deliveryCharge: tax);
      _order = _order.copyWith(total: _order.calculatedTotal);
    });
  }

  List<Widget> _deliveryRelated() {
    return [
      DeliveryAddressContainer(
        onAddressSelected: _onAddressSelected,
        deliveryAddress: _order.deliveryAddress,
      ),
      const SizedBox(height: 20),
      DeliveryTimeSettings(onTimeChanged: _onTimeChanged),
      const SizedBox(height: 20),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'Checkout', showAction: false),
      body: MultiBlocListener(
        listeners: [
          BlocListener<OrderBloc, OrderState>(
            bloc: orderBloc,
            listener: (context, state) {
              if (state is OrderSuccess) {
                Modular.to.pushNamed('/order/order-result', arguments: true);
              } else if (state is OrderError) {
                ModularUtils.showError(state.message);
                Modular.to.pushNamed('/order/order-result', arguments: false);
              }
            },
          ),
          BlocListener<CompanyDistrictBloc, CompanyDistrictState>(
            bloc: Modular.get<CompanyDistrictBloc>(),
            listener: (context, state) {
              if (state is CompanyDistrictTaxSuccess) {
                _onDistrictTaxChanged(state.tax);
              }
              if (state is CompanyDistrictError) {
                ModularUtils.showError(state.message);
              }
            },
          ),
        ],
        child: Column(
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
                      _OrderBill(_order),
                      const SizedBox(height: 20),
                      NotesContainer(onChange: _onNotesChange),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: BlocBuilder<OrderBloc, OrderState>(
                  bloc: orderBloc,
                  builder: (context, state) {
                    if (state is OrderLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return FilledButton(
                      text: 'Finalizar Pedido',
                      color: kSecondaryColor,
                      onPressed: _onPlaceOrder,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderBill extends StatelessWidget {
  const _OrderBill(this._order, {Key? key}) : super(key: key);

  final Order _order;

  @override
  Widget build(BuildContext context) {
    return InformationContainer(
      title: 'Resumo da Conta',
      child: TotalContainer(order: _order, showServiceCharge: true),
    );
  }
}

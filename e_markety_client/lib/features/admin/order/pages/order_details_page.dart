import 'package:e_markety_client/features/order/checkout/components/information_container.dart';
import 'package:e_markety_client/features/order/order/models/delivery_tipe.dart';
import 'package:e_markety_client/shared/extensions/double_extension.dart';
import 'package:e_markety_client/shared/extensions/string_extension.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/table_container.dart';
import '../../../order/shopping_cart/models/cart_item.dart';
import '../models/order_admin.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  final OrderAdmin order;

  FittedBox _buildRow(String key, dynamic value) {
    return FittedBox(
      child: Row(
        children: [
          Text('$key: ', style: kLabelLarge),
          Text('$value'),
        ],
      ),
    );
  }

  InformationContainer _customerInfo() {
    return InformationContainer(
      title: 'Cliente',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow('Nome', order.user.name),
          const SizedBox(height: 6),
          _buildRow('Email', order.user.email),
          const SizedBox(height: 6),
          if (order.user.phone != null) _buildRow('Telefone', order.user.phone),
        ],
      ),
    );
  }

  InformationContainer _addressInfo() {
    final address = order.deliveryAddress!;
    return InformationContainer(
      title: 'Endereço',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow('Nome', address.name),
          const SizedBox(height: 6),
          _buildRow(
            'Endereço',
            '${address.street} - ${address.district!.name}',
          ),
          const SizedBox(height: 6),
          _buildRow('Telefone', address.phone),
          if (address.reference.isNotBlank) const SizedBox(height: 6),
          if (address.reference.isNotBlank)
            _buildRow('Referência', address.reference),
        ],
      ),
    );
  }

  InformationContainer _dateInfo() {
    return InformationContainer(
      title: 'Data',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow('Data', DateTimeUtils.getyMd(order.createdAt!)),
          const SizedBox(height: 6),
          if (order.deliveryTime != null)
            _buildRow(
              'Horário da entrega',
              '${DateTimeUtils.getJm(order.deliveryTime!)} - '
                  '${DateTimeUtils.getJm(
                order.deliveryTime!.add(const Duration(hours: 1)),
              )}',
            ),
        ],
      ),
    );
  }

  InformationContainer _taxesAndTotal() {
    return InformationContainer(
      title: 'Total',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow('Subtotal', order.subTotal.toReal),
          if (order.discount > 0) const SizedBox(height: 6),
          if (order.discount > 0) _buildRow('Desconto', order.discount.toReal),
          if (order.deliveryCharge != null) const SizedBox(height: 6),
          if (order.deliveryCharge != null)
            _buildRow('Taxa de entrega', order.deliveryCharge?.toReal),
          const SizedBox(height: 6),
          _buildRow('Taxa de serviço', order.serviceCharge.toReal),
          const SizedBox(height: 6),
          _buildRow('Total', order.total.toReal),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: const Icon(Icons.arrow_back, color: kBasicDarkColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Detalhes'),
      ),
      body: TableContainer(
        title: 'Detalhes do pedido - OD${order.id}',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //TODO trocar por layoutBuilder, de acordo com o tamanho da tela
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _customerInfo()),
                const SizedBox(width: 16),
                if (order.deliveryType == DeliveryType.delivery)
                  Expanded(child: _addressInfo()),
                const SizedBox(width: 16),
                Expanded(child: _dateInfo()),
              ],
            ),
            const SizedBox(height: 16),
            _ItemsTable(items: order.items),
            const SizedBox(height: 20),
            _taxesAndTotal(),
          ],
        ),
      ),
    );
  }
}

final columns = [
  const DataColumn(label: Text('#')),
  const DataColumn(label: Text('Produto')),
  const DataColumn(label: Text('Preço unitário'), numeric: true),
  const DataColumn(label: Text('Quantidade'), numeric: true),
  const DataColumn(label: Text('Subtotal'), numeric: true),
];

class _ItemsTable extends StatelessWidget {
  const _ItemsTable({Key? key, required this.items}) : super(key: key);

  final List<CartItem> items;

  List<DataRow> _getRows() {
    return items
        .map(
          (item) => DataRow(
            cells: [
              DataCell(Text(item.product.id.toString())),
              DataCell(
                Row(
                  children: [
                    Container(
                      width: 75,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(item.product.imageUrl),
                        ),
                      ),
                    ),
                    Text(item.product.name),
                  ],
                ),
              ),
              DataCell(Text(item.product.price.toReal)),
              DataCell(Text(item.quantity.toString())),
              DataCell(Text(item.subTotal.toReal)),
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columns,
      rows: _getRows(),
    );
  }
}

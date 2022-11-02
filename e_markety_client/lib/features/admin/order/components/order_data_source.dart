import 'package:e_markety_client/features/admin/order/models/order_admin.dart';
import 'package:e_markety_client/features/admin/shared/data_responses/order_page_response.dart';
import 'package:e_markety_client/features/order/order/models/order_status.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

class OrderDataSource extends DataTableSource {
  final OrderPageResponse _pageResponse;

  OrderDataSource(this._pageResponse);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0, 'index deve ser maior que 0');

    if (index >= _pageResponse.totalElements) return null;

    OrderAdmin order;
    try {
      order = _pageResponse.content[index % _pageResponse.size];
    } catch (e) {
      return null;
    }

    return DataRow.byIndex(
      index: index,
      color: MaterialStateProperty.all(Colors.white),
      cells: [
        DataCell(
          Text(
            '${order.id}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(Text(order.user.name)),
        DataCell(Text(order.user.email)),
        DataCell(Text('\$${order.total.toStringAsFixed(2)}')),
        DataCell(_StatusChip(status: order.status)),
        DataCell(Text(order.createdAt.toString().split(' ')[0])),
        const DataCell(_ActionButton()),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _pageResponse.totalElements;

  @override
  int get selectedRowCount => 0;
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({Key? key, required this.status}) : super(key: key);

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label.toUpperCase(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        onPressed: () {},
        splashRadius: 20,
        hoverColor: kPrimaryColor.withOpacity(0.35),
        icon: const Icon(Icons.close, color: kPrimaryColor),
      ),
    );
  }
}

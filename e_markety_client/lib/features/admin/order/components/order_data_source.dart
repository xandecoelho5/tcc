import 'package:e_markety_client/features/admin/order/models/order_admin.dart';
import 'package:e_markety_client/features/admin/shared/data_responses/order_page_response.dart';
import 'package:e_markety_client/features/order/order/models/order_status.dart';
import 'package:e_markety_client/shared/extensions/double_extension.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
        DataCell(Text(order.total.toReal)),
        DataCell(_StatusChip(status: order.status)),
        DataCell(Text(DateTimeUtils.getyMd(order.createdAt!))),
        DataCell(_Actions(order: order)),
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

class _Actions extends StatelessWidget {
  const _Actions({Key? key, required this.order}) : super(key: key);

  final OrderAdmin order;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _InfoButton(order: order, alone: order.status == OrderStatus.delivered),
        if (order.status != OrderStatus.delivered)
          _ActionButton(id: order.id, status: order.status),
      ],
    );
  }
}

class _InfoButton extends StatefulWidget {
  const _InfoButton({
    Key? key,
    required this.order,
    required this.alone,
  }) : super(key: key);

  final OrderAdmin order;
  final bool alone;

  @override
  State<_InfoButton> createState() => _InfoButtonState();
}

class _InfoButtonState extends State<_InfoButton> {
  bool _isHovering = false;

  void _onHover(bool value) => setState(() => _isHovering = value);

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.alone
        ? const BorderRadius.all(Radius.circular(20))
        : const BorderRadius.horizontal(left: Radius.circular(20));

    return SizedBox(
      height: 30,
      width: widget.alone ? 85 : 50,
      child: Material(
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () => Modular.to.pushNamed(
            '/admin/order/details',
            arguments: widget.order,
          ),
          hoverColor: kSecondaryColor,
          onHover: _onHover,
          child: Theme(
            data: ThemeData(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: _isHovering ? kSecondaryColor : Colors.white,
                borderRadius: borderRadius,
                border: Border.all(color: kSecondaryColor),
              ),
              child: Center(
                child: Text(
                  'Info',
                  style: TextStyle(
                    color: _isHovering ? Colors.white : kSecondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  const _ActionButton({
    Key? key,
    required this.id,
    required this.status,
  }) : super(key: key);

  final int id;
  final OrderStatus status;

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isHovering = false;

  void _onHover(bool value) => setState(() => _isHovering = value);

  @override
  Widget build(BuildContext context) {
    final actions = widget.status.popupActions(widget.id);
    final entries = actions.entries.toList();

    const borderRadius = BorderRadius.horizontal(right: Radius.circular(20));

    return Container(
      height: 30,
      width: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        border: Border.all(color: kSecondaryColor),
      ),
      child: Material(
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () {},
          hoverColor: kSecondaryColor,
          onHover: _onHover,
          child: Theme(
            data: ThemeData(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: PopupMenuButton(
              tooltip: '',
              onSelected: (value) => actions[value]!(),
              itemBuilder: (context) => List.generate(
                entries.length,
                (index) => PopupMenuItem<String>(
                  value: entries[index].key,
                  child: Text(entries[index].key),
                ),
              ),
              child: Icon(
                Icons.arrow_drop_down,
                color: _isHovering ? Colors.white : kSecondaryColor,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

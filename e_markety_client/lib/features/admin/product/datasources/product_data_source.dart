import 'package:asuka/asuka.dart';
import 'package:e_markety_client/features/admin/product/blocs/admin_product_bloc.dart';
import 'package:e_markety_client/shared/data_responses/product_page_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/theme/constants.dart';
import '../../../product/models/product.dart';

class ProductDataSource extends DataTableSource {
  final ProductPageResponse _pageResponse;

  ProductDataSource(this._pageResponse);

  void _onDeleteProduct(int id) {
    Asuka.showDialog(
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir produto'),
          content: const Text('Deseja realmente excluir o produto?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Modular.get<AdminProductBloc>().add(ProductDeleteEvent(id));
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  DataRow? getRow(int index) {
    assert(index >= 0, 'index deve ser maior que 0');

    if (index >= _pageResponse.totalElements) return null;

    Product product;
    try {
      product = _pageResponse.content[index % _pageResponse.size];
    } catch (e) {
      return null;
    }

    return DataRow.byIndex(
      index: index,
      color: MaterialStateProperty.all(Colors.white),
      cells: [
        DataCell(
          Container(
            width: 75,
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(product.imageUrl)),
            ),
          ),
        ),
        DataCell(Text(product.name)),
        DataCell(Text('\$${product.price.toStringAsFixed(2)}')),
        DataCell(Text(product.formattedDiscount)),
        DataCell(Text(product.quantitySold.toString())),
        DataCell(Text(product.stock.toString())),
        DataCell(
          Row(
            children: [
              _ActionButton(
                iconData: Icons.edit,
                color: kSecondaryColor,
                onPressed: () =>
                    Modular.to.navigate('/admin/product/edit/${product.id}'),
              ),
              _ActionButton(
                iconData: Icons.delete,
                color: kPrimaryColor,
                onPressed: () => _onDeleteProduct(product.id!),
              ),
            ],
          ),
        ),
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

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        onPressed: onPressed,
        splashRadius: 20,
        hoverColor: color.withOpacity(0.35),
        icon: Icon(iconData, color: color),
      ),
    );
  }
}

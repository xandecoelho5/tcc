import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

import '../../../product/models/product.dart';

const columns = [
  'Produto',
  'Nome',
  'Preço',
  'Promoção',
  'Vendidos',
  'Estoque',
  'Ações',
];

class ProductDataTable extends StatelessWidget {
  const ProductDataTable({Key? key, required this.products}) : super(key: key);

  final List<Product> products;

  DataRow _buildDataRow(Product product) {
    return DataRow(
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
              IconButton(
                onPressed: () {},
                splashRadius: 20,
                splashColor: kSecondaryColor.withOpacity(0.5),
                icon: const Icon(Icons.edit, color: kSecondaryColor),
              ),
              IconButton(
                onPressed: () {},
                splashRadius: 20,
                splashColor: kPrimaryColor.withOpacity(0.5),
                icon: const Icon(Icons.delete, color: kPrimaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columns.map((c) => DataColumn(label: Text(c))).toList(),
      rows: products.map(_buildDataRow).toList(),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            spreadRadius: 1,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      dataTextStyle: const TextStyle(color: Color(0xFF8a909d), fontSize: 15),
      dataRowHeight: 60,
      headingTextStyle: const TextStyle(
        color: Color(0xFF56606e),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

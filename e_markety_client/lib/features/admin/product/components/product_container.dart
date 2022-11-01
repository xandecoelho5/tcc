import 'package:e_markety_client/features/admin/product/components/product_input_fields.dart';
import 'package:e_markety_client/features/admin/product/components/select_image.dart';
import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';
import '../../../../shared/widgets/filled_button.dart';
import '../../../../shared/widgets/table_container.dart';
import '../../../product/models/product.dart';

class ProductContainer extends StatefulWidget {
  const ProductContainer({
    Key? key,
    required this.product,
    required this.onSubmitProduct,
    required this.title,
    required this.buttonText,
  }) : super(key: key);

  final Product product;
  final void Function(Product) onSubmitProduct;
  final String title;
  final String buttonText;

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  late Product _product = widget.product;

  void _onProductChanged(Product v) {
    _product = _product.copyWith(
      name: v.name,
      imageUrl: v.imageUrl,
      quantitySold: v.quantitySold,
      description: v.description,
      price: v.price,
      stock: v.stock,
      weightPrice: v.weightPrice,
      weightUnit: v.weightUnit,
      discountPercent: v.discountPercent,
      category: v.category,
      measureUnit: v.measureUnit,
    );
  }

  final _formKey = GlobalKey<FormState>();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSubmitProduct(_product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TableContainer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Form(
                key: _formKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: SelectImage(
                        product: _product,
                        onProductChanged: _onProductChanged,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 8,
                      child: Column(
                        children: [
                          ProductInputFields(
                            product: _product,
                            onProductChanged: _onProductChanged,
                          ),
                          const SizedBox(height: 20),
                          FilledButton(
                            text: widget.buttonText,
                            color: kPrimaryColor,
                            onPressed: _onSubmit,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

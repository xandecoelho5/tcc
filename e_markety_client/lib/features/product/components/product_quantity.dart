import 'package:e_markety_client/features/product/models/product.dart';
import 'package:flutter/material.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/widgets/quantity_button.dart';

class ProductQuantity extends StatefulWidget {
  const ProductQuantity({
    Key? key,
    required this.product,
    required this.onChanged,
  }) : super(key: key);

  final Product product;
  final void Function(double) onChanged;

  @override
  State<ProductQuantity> createState() => _ProductQuantityState();
}

class _ProductQuantityState extends State<ProductQuantity> {
  double _quantity = 1;

  void _onMinusTapped() {
    setState(() {
      if (_quantity > widget.product.weightUnit) {
        _quantity -= widget.product.weightUnit;
        widget.onChanged(_quantity);
      }
    });
  }

  void _onPlusTapped() {
    setState(() {
      _quantity += widget.product.weightUnit;
      widget.onChanged(_quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kBasicLightColor.withOpacity(1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Quantidade',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kBasicLightColor),
              ),
              child: Row(
                children: [
                  QuantityButton.minus(
                    height: double.infinity,
                    onTap: _onMinusTapped,
                  ),
                  SizedBox(
                    width: 55,
                    child: Text(
                      _quantity.toStringAsFixed(widget.product.fractionDigits),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  QuantityButton.plus(
                    height: double.infinity,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    onTap: _onPlusTapped,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

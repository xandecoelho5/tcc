import 'package:dio/dio.dart';
import 'package:e_markety_client/features/admin/product/components/text_field_with_label.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:e_markety_client/shared/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../shared/utils/strings.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({
    Key? key,
    required this.product,
    required this.onProductChanged,
  }) : super(key: key);

  final Product product;
  final void Function(Product) onProductChanged;

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  late Product _product = widget.product;

  void _onUrlSaved(String? v) => _product = _product.copyWith(imageUrl: v);

  Future<void> _onFocusLost(String url) async {
    try {
      await Modular.get<Dio>().get(url);
      setState(() => _product = _product.copyWith(imageUrl: url));
    } catch (e) {
      setState(() => _product = _product.copyWith(imageUrl: ''));
    }
    widget.onProductChanged(_product);
  }

  Widget _buildImage() {
    if (_product.imageUrl.isEmpty) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: Image.asset(Assets.productPlaceholder, fit: BoxFit.cover),
      );
    }
    return Image.network(_product.imageUrl, fit: BoxFit.contain);
  }

  // https://i.pinimg.com/236x/7d/0e/68/7d0e68d3982cf67cfe6504e165029bd1--wattpad-book.jpg
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWithLabel(
          label: 'Imagem',
          onFocusLost: _onFocusLost,
          data: _product.imageUrl,
          onSaved: _onUrlSaved,
          onValidate: Validatorless.required(Strings.obrigatorio),
        ),
        const SizedBox(height: 20),
        Container(
          height: 400,
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: const Color(0XFFEEEEEE)),
          ),
          child: _buildImage(),
        ),
      ],
    );
  }
}

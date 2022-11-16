import 'package:e_markety_client/features/admin/product/components/dropdown_with_label.dart';
import 'package:e_markety_client/features/admin/product/components/text_field_with_label.dart';
import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/features/product/models/measure_unit.dart';
import 'package:e_markety_client/shared/utils/mask_formatter_utils.dart';
import 'package:e_markety_client/shared/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../product/models/product.dart';
import '../notifiers/category_notifier.dart';
import '../notifiers/measure_unit_notifier.dart';

class ProductInputFields extends StatefulWidget {
  const ProductInputFields({
    Key? key,
    required this.product,
    required this.onProductChanged,
  }) : super(key: key);

  final Product product;
  final void Function(Product) onProductChanged;

  @override
  State<ProductInputFields> createState() => _ProductInputFieldsState();
}

class _ProductInputFieldsState extends State<ProductInputFields> {
  late Product _product = widget.product;

  late final _inputSaveMap = <String, void Function(String?)>{
    'name': (v) => _product = _product.copyWith(name: v),
    'description': (v) => _product = _product.copyWith(description: v),
    'price': (v) =>
        _product = _product.copyWith(price: double.tryParse(v ?? '0') ?? 0),
    'stock': (v) =>
        _product = _product.copyWith(stock: double.tryParse(v ?? '0') ?? 0),
    'weightPrice': (v) => _product =
        _product.copyWith(weightPrice: double.tryParse(v ?? '0') ?? 0),
    'weightUnit': (v) => _product =
        _product.copyWith(weightUnit: double.tryParse(v ?? '0') ?? 0),
    'discountPercent': (v) => _product =
        _product.copyWith(discountPercent: int.tryParse(v ?? '0') ?? 0),
  };

  void _onSaved(String? field, String? value) {
    _inputSaveMap[field]?.call(value);
    widget.onProductChanged(_product);
  }

  void _onCategorySaved(Category? v) {
    _product = _product.copyWith(category: v);
    widget.onProductChanged(_product);
  }

  void _onMeasureUnitSaved(MeasureUnit? v) {
    _product = _product.copyWith(measureUnit: v);
    widget.onProductChanged(_product);
  }

  String? _onValidateCategory(Category? v) =>
      v == null ? Strings.obrigatorio : null;

  String? _onValidateMeasureUnit(MeasureUnit? v) =>
      v == null ? Strings.obrigatorio : null;

  String? _onValidateWeight(String? v) {
    if (v == null || v.isEmpty || v == '0.0') {
      return null;
    }
    return Validatorless.numbersBetweenInterval(
      0.01,
      99999,
      Strings.valorMinimo,
    )(v);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFieldWithLabel(
                label: 'Nome',
                fieldName: 'name',
                data: _product.name,
                onCustomSaved: _onSaved,
                onValidate: Validatorless.required(Strings.obrigatorio),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ValueListenableBuilder<List<Category>>(
                valueListenable: Modular.get<CategoryNotifier>(),
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return DropdownWithLabel(
                    label: 'Categoria',
                    data: _product.category,
                    items: value,
                    onSaved: _onCategorySaved,
                    onValidate: _onValidateCategory,
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: TextFieldWithLabel(
                label: 'Descrição',
                fieldName: 'description',
                data: _product.description,
                onCustomSaved: _onSaved,
                onValidate: Validatorless.required(Strings.obrigatorio),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: TextFieldWithLabel(
                label: 'Preço',
                fieldName: 'price',
                data: _product.price.toString(),
                onCustomSaved: _onSaved,
                onValidate: Validatorless.multiple([
                  Validatorless.required(Strings.obrigatorio),
                  Validatorless.numbersBetweenInterval(
                    0.01,
                    99999,
                    Strings.valorMinimo,
                  ),
                ]),
                inputFormatters: [MaskFormatterUtils.decimalNumber],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFieldWithLabel(
                label: 'Estoque',
                fieldName: 'stock',
                data: _product.stock.toString(),
                onCustomSaved: _onSaved,
                inputFormatters: [MaskFormatterUtils.decimalNumber],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFieldWithLabel(
                label: 'Percentual de Desconto',
                fieldName: 'discountPercent',
                data: _product.discountPercent.toString(),
                onCustomSaved: _onSaved,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ValueListenableBuilder<List<MeasureUnit>>(
                valueListenable: Modular.get<MeasureUnitNotifier>(),
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return DropdownWithLabel(
                    label: 'Unidade de Medida',
                    data: _product.measureUnit,
                    items: value,
                    onSaved: _onMeasureUnitSaved,
                    onValidate: _onValidateMeasureUnit,
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFieldWithLabel(
                label: 'Peso Preço',
                fieldName: 'weightPrice',
                data: _product.weightPrice.toString(),
                onCustomSaved: _onSaved,
                onValidate: _onValidateWeight,
                inputFormatters: [MaskFormatterUtils.decimalNumber],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFieldWithLabel(
                label: 'Peso Unidade',
                fieldName: 'weightUnit',
                data: _product.weightUnit.toString(),
                onCustomSaved: _onSaved,
                onValidate: _onValidateWeight,
                inputFormatters: [MaskFormatterUtils.decimalNumber],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

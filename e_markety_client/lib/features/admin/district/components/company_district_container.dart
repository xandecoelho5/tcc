import 'package:e_markety_client/features/company/models/company_district.dart';
import 'package:e_markety_client/shared/widgets/table_container.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../shared/theme/constants.dart';
import '../../../../shared/utils/mask_formatter_utils.dart';
import '../../../../shared/utils/strings.dart';
import '../../../../shared/widgets/filled_button.dart';
import '../../../order/address/models/district.dart';
import '../../product/components/dropdown_with_label.dart';
import '../../product/components/text_field_with_label.dart';

class CompanyDistrictContainer extends StatefulWidget {
  const CompanyDistrictContainer({
    Key? key,
    required this.companyDistrict,
    required this.onSubmit,
    required this.title,
    required this.buttonText,
    required this.districts,
  }) : super(key: key);

  final CompanyDistrict companyDistrict;
  final Function(CompanyDistrict) onSubmit;
  final String title;
  final String buttonText;
  final List<District> districts;

  @override
  State<CompanyDistrictContainer> createState() =>
      _CompanyDistrictContainerState();
}

class _CompanyDistrictContainerState extends State<CompanyDistrictContainer> {
  late CompanyDistrict _companyDistrict = widget.companyDistrict;

  final _formKey = GlobalKey<FormState>();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSubmit(_companyDistrict);
    }
  }

  void _onDeliveryChargeSaved(String? v) {
    _companyDistrict = _companyDistrict.copyWith(
      deliveryCharge: double.tryParse(v ?? '0') ?? 0,
    );
  }

  void _onDistrictSaved(District? v) =>
      _companyDistrict = _companyDistrict.copyWith(district: v);

  String? _onValidateDistrict(District? v) =>
      v == null ? Strings.obrigatorio : null;

  @override
  Widget build(BuildContext context) {
    return TableContainer(
      title: widget.title,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownWithLabel(
                label: 'Bairro',
                data: _companyDistrict.district,
                items: widget.districts,
                onSaved: _onDistrictSaved,
                onValidate: _onValidateDistrict,
                disabled: widget.buttonText == 'Editar',
              ),
              const SizedBox(height: 16),
              TextFieldWithLabel(
                label: 'Taxa de Entrega',
                data: _companyDistrict.deliveryCharge.toString(),
                onSaved: _onDeliveryChargeSaved,
                onValidate: Validatorless.multiple([
                  Validatorless.required(Strings.obrigatorio),
                  Validatorless.numbersBetweenInterval(
                    0,
                    999,
                    Strings.valorEntre,
                  ),
                ]),
                inputFormatters: [MaskFormatterUtils.decimalNumber],
              ),
              const SizedBox(height: 16),
              FilledButton(
                text: widget.buttonText,
                color: kPrimaryColor,
                onPressed: _onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

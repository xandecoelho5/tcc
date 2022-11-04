import 'package:e_markety_client/features/admin/product/components/dropdown_with_label.dart';
import 'package:e_markety_client/features/order/address/blocs/address/address_bloc.dart';
import 'package:e_markety_client/features/order/address/components/notifiers/district_notifier.dart';
import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:e_markety_client/features/order/address/models/district.dart';
import 'package:e_markety_client/shared/utils/mask_formatter_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../shared/theme/constants.dart';
import '../../../../shared/utils/strings.dart';
import '../../../../shared/widgets/filled_button.dart';
import '../../../admin/product/components/text_field_with_label.dart';
import '../models/tag.dart';

class AddressContainer extends StatefulWidget {
  const AddressContainer({
    Key? key,
    required this.address,
    required this.onSubmitAddress,
  }) : super(key: key);

  final Address address;
  final void Function(Address) onSubmitAddress;

  @override
  State<AddressContainer> createState() => _AddressContainerState();
}

class _AddressContainerState extends State<AddressContainer> {
  late Address _address = widget.address;

  late final _inputSaveMap = <String, void Function(String?)>{
    'name': (v) => _address = _address.copyWith(name: v),
    'phone': (v) => _address = _address.copyWith(phone: v),
    'street': (v) => _address = _address.copyWith(street: v),
    'reference': (v) => _address = _address.copyWith(reference: v),
  };

  void _onSaved(String? field, String? value) {
    _inputSaveMap[field]?.call(value);
    // widget.onSubmitAddress(_address);
  }

  void _onTagSaved(Tag? v) {
    _address = _address.copyWith(tag: v);
    // widget.onSubmitAddress(_address);
  }

  void _onDistrictSaved(District? v) {
    _address = _address.copyWith(district: v);
    // widget.onSubmitAddress(_address);
  }

  void _onDefaultChanged(bool? v) {
    _address = _address.copyWith(isDefault: v);
    // widget.onSubmitAddress(_address);
  }

  String? _onValidateDistrict(District? v) =>
      v == null ? Strings.obrigatorio : null;

  final _formKey = GlobalKey<FormState>();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Modular.get<AddressBloc>().add(AddressEditEvent(_address));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFieldWithLabel(
                      label: 'Nome',
                      fieldName: 'name',
                      data: _address.name,
                      onCustomSaved: _onSaved,
                      onValidate: Validatorless.required(Strings.obrigatorio),
                    ),
                    const SizedBox(height: 12),
                    TextFieldWithLabel(
                      label: 'Telefone',
                      fieldName: 'phone',
                      data: _address.phone,
                      onCustomSaved: _onSaved,
                      onValidate: Validatorless.required(Strings.obrigatorio),
                      inputFormatters: [MaskFormatterUtils.cellPhone],
                    ),
                    const SizedBox(height: 12),
                    TextFieldWithLabel(
                      label: 'Rua',
                      fieldName: 'street',
                      data: _address.street,
                      onCustomSaved: _onSaved,
                      onValidate: Validatorless.required(Strings.obrigatorio),
                    ),
                    const SizedBox(height: 12),
                    ValueListenableBuilder<List<District>>(
                      valueListenable: Modular.get<DistrictNotifier>(),
                      builder: (context, value, child) {
                        if (value.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return DropdownWithLabel(
                          label: 'Bairro',
                          data: _address.district,
                          items: value,
                          onSaved: _onDistrictSaved,
                          onValidate: _onValidateDistrict,
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFieldWithLabel(
                      label: 'Referência',
                      fieldName: 'reference',
                      data: _address.reference,
                      onCustomSaved: _onSaved,
                    ),
                    const SizedBox(height: 12),
                    DropdownWithLabel<Tag>(
                      label: 'Tag',
                      data: _address.tag,
                      items: Tag.values,
                      onSaved: _onTagSaved,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: kPrimaryColor,
                          value: _address.isDefault,
                          onChanged: _onDefaultChanged,
                        ),
                        Text(
                          'Endereço padrão de entrega',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: FilledButton(
              text: 'Salvar',
              color: kSecondaryColor,
              onPressed: _onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}

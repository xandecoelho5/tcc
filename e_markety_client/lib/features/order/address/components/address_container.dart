import 'package:e_markety_client/features/admin/district/notifiers/district_notifier.dart';
import 'package:e_markety_client/features/admin/product/components/dropdown_with_label.dart';
import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:e_markety_client/features/order/address/models/district.dart';
import 'package:e_markety_client/shared/environment/platform.dart';
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
    required this.textButton,
  }) : super(key: key);

  final Address address;
  final void Function(Address) onSubmitAddress;
  final String textButton;

  @override
  State<AddressContainer> createState() => _AddressContainerState();
}

class _AddressContainerState extends State<AddressContainer> {
  late Address _address = widget.address;
  late bool _isDefault = _address.isDefault;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Modular.get<DistrictNotifier>().fetchAllData();
  }

  late final _inputSaveMap = <String, void Function(String?)>{
    'name': (v) => _address = _address.copyWith(name: v),
    'phone': (v) => _address = _address.copyWith(phone: v),
    'street': (v) => _address = _address.copyWith(street: v),
    'reference': (v) => _address = _address.copyWith(reference: v),
  };

  void _onSaved(String? field, String? value) =>
      _inputSaveMap[field]?.call(value);

  void _onTagSaved(Tag? v) => _address = _address.copyWith(tag: v);

  void _onDistrictSaved(District? v) =>
      _address = _address.copyWith(district: v);

  void _onDefaultChanged(bool? v) {
    setState(() {
      _isDefault = v!;
      _address = _address.copyWith(isDefault: _isDefault);
    });
  }

  String? _onValidateDistrict(District? v) =>
      v == null ? Strings.obrigatorio : null;

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSubmitAddress(_address);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
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
                      onValidate: Validatorless.multiple([
                        Validatorless.required(Strings.obrigatorio),
                        Validatorless.min(
                          Modular.get<AppPlatform>().isMobile ? 15 : 14,
                          Strings.telefoneInvalido,
                        ),
                      ]),
                      inputFormatters: [MaskFormatterUtils.cellPhone],
                      keyboardType: TextInputType.phone,
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
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: kPrimaryColor,
                          value: _isDefault,
                          onChanged: _onDefaultChanged,
                        ),
                        Text(
                          'Endereço padrão para entregas',
                          style: kTitleMedium.copyWith(
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: FilledButton(
            height: MediaQuery.of(context).size.height * 0.075,
            text: widget.textButton,
            color: kSecondaryColor,
            onPressed: _onSubmit,
          ),
        ),
      ],
    );
  }
}

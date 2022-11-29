import 'package:dio/dio.dart';
import 'package:e_markety_client/features/company/blocs/company/company_bloc.dart';
import 'package:e_markety_client/features/company/models/company.dart';
import 'package:e_markety_client/features/order/address/models/address.dart';
import 'package:e_markety_client/shared/extensions/string_extension.dart';
import 'package:e_markety_client/shared/utils/date_time_utils.dart';
import 'package:e_markety_client/shared/utils/mask_formatter_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../shared/theme/constants.dart';
import '../../../../shared/utils/assets.dart';
import '../../../../shared/utils/modular_utils.dart';
import '../../../../shared/utils/strings.dart';
import '../../../../shared/widgets/filled_button.dart';
import '../../../../shared/widgets/table_container.dart';
import '../../product/components/text_field_with_label.dart';

class CompanyContainer extends StatefulWidget {
  const CompanyContainer({Key? key, required this.company}) : super(key: key);

  final Company company;

  @override
  State<CompanyContainer> createState() => _CompanyContainerState();
}

class _CompanyContainerState extends State<CompanyContainer> {
  late Company _company = widget.company;

  final _formKey = GlobalKey<FormState>();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_validateTimeFields()) {
        Modular.get<CompanyBloc>().add(CompanyUpdateEvent(_company));
      }
    }
  }

  late final _inputSaveMap = <String, void Function(String?)>{
    'name': (v) => _company = _company.copyWith(name: v),
    'phone': (v) => _company = _company.copyWith(phone: v),
    'cellPhone': (v) => _company = _company.copyWith(cellPhone: v),
    'logoUrl': (v) => _company = _company.copyWith(logoUrl: v),
    'deliveryOpeningTime': (v) =>
        _company = _company.copyWith(deliveryOpeningTime: v),
    'deliveryClosingTime': (v) =>
        _company = _company.copyWith(deliveryClosingTime: v),
    'storeOpeningTime': (v) =>
        _company = _company.copyWith(storeOpeningTime: v),
    'storeClosingTime': (v) =>
        _company = _company.copyWith(storeClosingTime: v),
    'banners': (v) => _company = _company.copyWith(
          banners: v?.split('\n').map((e) => e.trim()).toList(),
        ),
    'serviceCharge': (v) => _company =
        _company.copyWith(serviceCharge: double.tryParse(v ?? '0') ?? 0),
  };

  void _onSaved(String? field, String? value) {
    _inputSaveMap[field]?.call(value);
  }

  void _onEditAddress(Address? v) => setState(() {
        _company = _company.copyWith(address: v);
      });

  Future<void> _onFocusLost(String url) async {
    try {
      await Modular.get<Dio>().get(url);
      setState(() => _company = _company.copyWith(logoUrl: url));
    } catch (e) {
      setState(() => _company = _company.copyWith(logoUrl: ''));
    }
  }

  bool _validateTimeFields() {
    var message = _onValidateTime(
      _company.deliveryOpeningTime,
      _company.deliveryClosingTime,
    );
    if (message != null) {
      ModularUtils.showError(message);
      return false;
    }
    message = _onValidateTime(
      _company.storeOpeningTime,
      _company.storeClosingTime,
    );
    if (message != null) {
      ModularUtils.showError(message);
      return false;
    }
    return true;
  }

  String? _onValidateTime(String? opening, String? closing) {
    if (!_hasAnyTimeSetted(opening, closing)) {
      return null;
    }

    final dateOpening = DateTimeUtils.fromString(opening!);
    final dateClosing = DateTimeUtils.fromString(closing!);

    if (dateOpening == null || dateClosing == null) {
      return Strings.ambosHorariosObrigatorios;
    }
    if (dateOpening.isAfter(dateClosing)) {
      return Strings.horarioAberturaMaiorQueFechamento;
    }
    return null;
  }

  bool _hasAnyTimeSetted(String? opening, String? closing) {
    if ((opening == null || opening.isEmpty) &&
        (closing == null || closing.isEmpty)) {
      return false;
    }
    return true;
  }

  Expanded _buildLogo() {
    Widget buildImage() {
      if (_company.logoUrl.isEmpty) {
        return Container(
          margin: const EdgeInsets.all(10),
          child: Image.asset(Assets.productPlaceholder, fit: BoxFit.cover),
        );
      }
      return Image.network(_company.logoUrl, fit: BoxFit.contain);
    }

    return Expanded(
      flex: 4,
      child: Column(
        children: [
          TextFieldWithLabel(
            label: 'Logo',
            fieldName: 'logoUrl',
            onFocusLost: _onFocusLost,
            data: _company.logoUrl,
            onCustomSaved: _onSaved,
            onValidate: Validatorless.required(Strings.obrigatorio),
          ),
          const SizedBox(height: 20),
          Container(
            height: 400,
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: kAdminContainerDecoration,
            child: buildImage(),
          ),
        ],
      ),
    );
  }

  Expanded _buildInputs() {
    return Expanded(
      flex: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFieldWithLabel(
            label: 'Nome',
            fieldName: 'name',
            data: _company.name,
            onCustomSaved: _onSaved,
            onValidate: Validatorless.required(Strings.obrigatorio),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextFieldWithLabel(
                  label: 'Telefone',
                  fieldName: 'phone',
                  data: _company.phone,
                  onCustomSaved: _onSaved,
                  onValidate: Validatorless.multiple([
                    Validatorless.required(Strings.obrigatorio),
                    Validatorless.min(14, Strings.telefoneInvalido),
                  ]),
                  inputFormatters: [MaskFormatterUtils.phone],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFieldWithLabel(
                  label: 'Celular',
                  fieldName: 'cellPhone',
                  data: _company.cellPhone,
                  onCustomSaved: _onSaved,
                  onValidate: (value) {
                    if (value.isNotBlank) {
                      return null;
                    }
                    return Validatorless.min(15, Strings.celularInvalido)(
                      value,
                    );
                  },
                  inputFormatters: [MaskFormatterUtils.cellPhone],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextFieldWithLabel(
                  label: 'Horário de Abertura',
                  fieldName: 'storeOpeningTime',
                  data: _company.storeOpeningTime,
                  onCustomSaved: _onSaved,
                  inputFormatters: [MaskFormatterUtils.time],
                  onValidate: Validatorless.min(5, Strings.horarioInvalido),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFieldWithLabel(
                  label: 'Horário de Fechamento',
                  fieldName: 'storeClosingTime',
                  data: _company.storeClosingTime,
                  onCustomSaved: _onSaved,
                  inputFormatters: [MaskFormatterUtils.time],
                  onValidate: Validatorless.min(5, Strings.horarioInvalido),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextFieldWithLabel(
                  label: 'Horário de Abertura para Entregas',
                  fieldName: 'deliveryOpeningTime',
                  data: _company.deliveryOpeningTime,
                  onCustomSaved: _onSaved,
                  inputFormatters: [MaskFormatterUtils.time],
                  onValidate: Validatorless.min(5, Strings.horarioInvalido),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFieldWithLabel(
                  label: 'Horário de Fechamento para Entregas',
                  fieldName: 'deliveryClosingTime',
                  data: _company.deliveryClosingTime,
                  onCustomSaved: _onSaved,
                  inputFormatters: [MaskFormatterUtils.time],
                  onValidate: Validatorless.min(5, Strings.horarioInvalido),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFieldWithLabel(
                  label: 'Taxa de Serviço',
                  fieldName: 'serviceCharge',
                  data: _company.serviceCharge.toString(),
                  onCustomSaved: _onSaved,
                  onValidate: Validatorless.required(Strings.obrigatorio),
                  inputFormatters: [MaskFormatterUtils.decimalNumber],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 7,
                child: _AddressInput(
                  address: _company.address,
                  onEditAddress: _onEditAddress,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton(
            text: 'Salvar',
            color: kPrimaryColor,
            onPressed: _onSubmit,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TableContainer(
      title: 'Configurações da Empresa',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFieldWithLabel(
              label: 'Banners',
              maxLines: 5,
              fieldName: 'banners',
              data: _company.banners.join('\n'),
              onCustomSaved: _onSaved,
              onValidate: Validatorless.required(Strings.obrigatorio),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogo(),
                const SizedBox(width: 20),
                _buildInputs(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressInput extends StatefulWidget {
  const _AddressInput({
    Key? key,
    required this.address,
    required this.onEditAddress,
  }) : super(key: key);

  final Address address;
  final void Function(Address) onEditAddress;

  @override
  State<_AddressInput> createState() => _AddressInputState();
}

class _AddressInputState extends State<_AddressInput> {
  late Address _address = widget.address;

  Future<void> _onEditAddress() async {
    final address = await Modular.to.pushNamed(
      '/admin/settings/address/edit/${widget.address.id}',
    );
    if (address != null) {
      _address = address as Address;
      widget.onEditAddress(_address);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 9,
          child: TextFieldWithLabel(
            label: 'Endereço',
            data: _address.name,
            onValidate: Validatorless.required(Strings.obrigatorio),
            readOnly: true,
          ),
        ),
        const SizedBox(width: 8),
        Material(
          color: Colors.transparent,
          child: IconButton(
            onPressed: _onEditAddress,
            splashRadius: 20,
            hoverColor: kSecondaryColor.withOpacity(0.35),
            icon: const Icon(Icons.edit_outlined, color: kSecondaryColor),
          ),
        ),
      ],
    );
  }
}

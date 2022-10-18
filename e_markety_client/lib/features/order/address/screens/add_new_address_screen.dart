import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:e_markety_client/shared/widgets/custom_text_form_field.dart';
import 'package:e_markety_client/shared/widgets/filled_button.dart';
import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';
import '../models/tag.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  Tag _tag = Tag.other;
  bool _isDefault = false;

  Expanded _dropdown() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton<Tag>(
          // isExpanded: true,
          value: _tag,
          items: Tag.values
              .map(
                (tag) => DropdownMenuItem<Tag>(
                  value: tag,
                  child: Text(tag.label),
                ),
              )
              .toList(),
          onChanged: (newValue) => setState(() => _tag = newValue!),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        context,
        title: 'Adicionar Novo Endereço',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      CustomTextFormField(label: 'Nome'),
                      const SizedBox(height: 12),
                      CustomTextFormField(label: 'Nº Telefone'),
                      const SizedBox(height: 12),
                      CustomTextFormField(label: 'Rua'),
                      const SizedBox(height: 12),
                      CustomTextFormField(label: 'Bairro'),
                      const SizedBox(height: 12),
                      CustomTextFormField(label: 'Referência'),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            'Tag: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _dropdown(),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: kPrimaryColor,
                            value: _isDefault,
                            onChanged: (value) =>
                                setState(() => _isDefault = value!),
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
                text: 'Save Address',
                color: kSecondaryColor,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/custom_text_form_field.dart';

class EmailPasswordComponent extends StatelessWidget {
  const EmailPasswordComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomTextFormField(
          label: 'E-mail',
          icon: true
              ? Icon(Icons.check_circle_outline, color: kSecondaryColor)
              : Icon(Icons.cancel_outlined, color: kPrimaryColor),
        ),
        SizedBox(height: 20),
        CustomTextFormField(
          label: 'Senha',
          icon: Icon(Icons.visibility, color: Colors.grey),
        ),
      ],
    );
  }
}

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
              ? Icon(Icons.check_circle_outline, color: Colors.lightGreen)
              : Icon(Icons.cancel_outlined, color: Colors.redAccent),
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

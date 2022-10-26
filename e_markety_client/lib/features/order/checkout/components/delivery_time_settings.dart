import 'package:flutter/material.dart';

import 'information_container.dart';

class DeliveryTimeSettings extends StatelessWidget {
  const DeliveryTimeSettings({Key? key}) : super(key: key);

  DropdownButtonFormField<int> _dropdown() {
    const start = 9;
    const end = 17;
    return DropdownButtonFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
      ),
      value: start,
      items: List.generate(end - start + 1, (index) => index + start)
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text('$e:00 - ${e + 1}:00'),
            ),
          )
          .toList(),
      onChanged: (value) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InformationContainer(
      title: 'Horário de Entrega',
      child: _dropdown(),
    );
  }
}

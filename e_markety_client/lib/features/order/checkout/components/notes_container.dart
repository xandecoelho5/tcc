import 'package:flutter/material.dart';

import 'information_container.dart';

class NotesContainer extends StatelessWidget {
  const NotesContainer({Key? key, required this.onChange}) : super(key: key);

  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
    );

    return InformationContainer(
      title: 'Observações',
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Escreva alguma coisa aqui caso precisar...',
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.bold,
          ),
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          fillColor: Colors.white,
          filled: true,
        ),
        maxLines: 3,
        onChanged: onChange,
      ),
    );
  }
}

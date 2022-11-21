import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({
    Key? key,
    this.text = 'Nenhum registro encontrado',
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(text, style: kTitleLarge),
    );
  }
}

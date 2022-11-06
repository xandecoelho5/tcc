import 'package:e_markety_client/shared/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../theme/constants.dart';

class SlidableCard extends StatelessWidget {
  const SlidableCard({
    Key? key,
    required this.child,
    required this.valueKey,
    required this.onConfirmDelete,
  }) : super(key: key);

  final Widget child;
  final int valueKey;
  final void Function() onConfirmDelete;

  Future<bool> _confirmDelete() async {
    return DialogUtils.showDialog(
      'Remover Produto',
      'Você quer realmente remover este produto da sua lista?',
      onConfirmDelete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(valueKey),
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.only(left: 16),
              child: Material(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: _confirmDelete,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}

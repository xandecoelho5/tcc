import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../theme/constants.dart';

class SlidableCard extends StatelessWidget {
  const SlidableCard({
    Key? key,
    required this.child,
    required this.valueKey,
  }) : super(key: key);

  final Widget child;
  final int valueKey;

  Future<bool> _confirmDelete(context) async {
    return await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
          'Do you want to remove this product from your list?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(valueKey),
      endActionPane: ActionPane(
        extentRatio: 0.35,
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
                  onTap: () => _confirmDelete(context),
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

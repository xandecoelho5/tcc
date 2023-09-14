import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

class ViewAllRow extends StatelessWidget {
  const ViewAllRow({
    Key? key,
    required this.text,
    this.buttonText = 'Ver todos',
    this.onViewAll,
  }) : super(key: key);

  final String text;
  final String buttonText;
  final void Function()? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          TextButton(
            onPressed: onViewAll,
            child: Row(
              children: [
                Text(buttonText, style: kLabelLargeDark),
                const SizedBox(width: 2),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: kBasicDarkColor,
                  size: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

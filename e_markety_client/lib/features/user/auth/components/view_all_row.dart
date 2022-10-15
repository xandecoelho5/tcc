import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

class ViewAllRow extends StatelessWidget {
  const ViewAllRow({
    Key? key,
    required this.text,
    this.onViewAll,
  }) : super(key: key);

  final String text;
  final Function? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              // color: Theme.of(context).colorScheme.secondary,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              children: const [
                Text(
                  'View All',
                  style: TextStyle(
                    color: kBasicDarkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 2),
                Icon(Icons.arrow_forward_ios, color: kBasicDarkColor, size: 12),
              ],
            ),
          )
        ],
      ),
    );
  }
}

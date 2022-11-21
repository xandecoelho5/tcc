import 'package:e_markety_client/features/order/checkout/components/information_container.dart';
import 'package:e_markety_client/features/product/models/sort_type.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

class SortOptions extends StatefulWidget {
  const SortOptions({
    Key? key,
    required this.sortType,
    required this.onChangeSortType,
  }) : super(key: key);

  final SortType sortType;
  final void Function(SortType) onChangeSortType;

  @override
  State<SortOptions> createState() => _SortOptionsState();
}

class _SortOptionsState extends State<SortOptions> {
  late SortType _sortType = widget.sortType;

  @override
  Widget build(BuildContext context) {
    return InformationContainer(
      title: 'Ordenação',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: List.generate(
            SortType.values.length,
            (index) {
              final type = SortType.values[index];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        type.label,
                        style: kTitleLarge.copyWith(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: type == _sortType
                              ? kPrimaryColor
                              : kScaffoldColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: type == _sortType
                                ? kPrimaryColor
                                : Colors.grey.shade400,
                          ),
                        ),
                        child: Material(
                          shape: const CircleBorder(),
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() => _sortType = type);
                              widget.onChangeSortType(type);
                            },
                            child: type == _sortType
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (index != SortType.values.length - 1)
                    const Divider(height: 24, thickness: 1.5),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

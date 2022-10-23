import 'package:e_markety_client/features/order/checkout/components/information_container.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

const min = 0.0;
const max = 500.0;

class PriceRange extends StatefulWidget {
  const PriceRange({
    Key? key,
    required this.values,
    required this.onPriceChanged,
  }) : super(key: key);

  final RangeValues values;
  final void Function(SfRangeValues) onPriceChanged;

  @override
  State<PriceRange> createState() => _PriceRangeState();
}

class _PriceRangeState extends State<PriceRange> {
  late SfRangeValues _values = SfRangeValues(
    widget.values.start,
    widget.values.end,
  );

  @override
  Widget build(BuildContext context) {
    return InformationContainer(
      title: 'Preço',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${min.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${max.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SfRangeSliderTheme(
              data: SfRangeSliderThemeData(
                // inactiveTrackColor: kScaffoldColor,
                thumbColor: kPrimaryColor,
                thumbStrokeColor: Colors.white,
                thumbStrokeWidth: 5,
                thumbRadius: 14,
                overlayRadius: 12,
                activeTrackHeight: 8,
                inactiveTrackHeight: 8,
                overlappingThumbStrokeColor: kPrimaryColor,
                overlappingTooltipStrokeColor: kPrimaryColor,
              ),
              child: Column(
                children: [
                  SfRangeSlider(
                    max: max,
                    values: _values,
                    enableTooltip: true,
                    tooltipTextFormatterCallback: (actualValue, formattedText) {
                      return '\$${actualValue.toStringAsFixed(2)}';
                    },
                    onChanged: (values) {
                      setState(() => _values = values);
                      widget.onPriceChanged(_values);
                    },
                    // onChangeEnd: widget.onChangeEnd,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

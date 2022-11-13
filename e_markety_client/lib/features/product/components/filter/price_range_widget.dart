import 'package:e_markety_client/features/order/checkout/components/information_container.dart';
import 'package:e_markety_client/shared/extensions/double_extension.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class PriceRangeWidget extends StatefulWidget {
  const PriceRangeWidget({
    Key? key,
    required this.values,
    required this.onPriceChanged,
    required this.min,
    required this.max,
  }) : super(key: key);

  final RangeValues values;
  final void Function(SfRangeValues) onPriceChanged;
  final double min;
  final double max;

  @override
  State<PriceRangeWidget> createState() => _PriceRangeWidgetState();
}

class _PriceRangeWidgetState extends State<PriceRangeWidget> {
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
                  widget.min.toReal,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.max.toReal,
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
                    min: widget.min,
                    max: widget.max,
                    values: _values,
                    enableTooltip: true,
                    tooltipTextFormatterCallback: (actualValue, formattedText) {
                      return (actualValue as double).toReal;
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

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/theme/constants.dart';
import '../../models/status_summary.dart';

class OrdersOverviewChart extends StatefulWidget {
  const OrdersOverviewChart({
    Key? key,
    required this.statusSummary,
  }) : super(key: key);

  final List<StatusSummary> statusSummary;

  @override
  State<OrdersOverviewChart> createState() => _OrdersOverviewChartState();
}

class _OrdersOverviewChartState extends State<OrdersOverviewChart> {
  int touchedIndex = -1;

  List<Widget> _buildIndicators() {
    return widget.statusSummary
        .map(
          (s) => Column(
            children: [
              Indicator(
                color: s.status.color,
                text: s.status.label,
                isSquare: true,
              ),
              const SizedBox(height: 4),
            ],
          ),
        )
        .toList();
  }

  List<PieChartSectionData> _showingSections() {
    return widget.statusSummary.map((s) {
      final isTouched = widget.statusSummary.indexOf(s) == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 90.0 : 80.0;
      return PieChartSectionData(
        color: s.status.color,
        value: s.percentage,
        title: '${s.percentage.toStringAsFixed(2)}%',
        radius: radius,
        titleStyle: kLabelLargeLight.copyWith(fontSize: fontSize),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          const SizedBox(height: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 12, 0),
                  child: Text(
                    'Visão geral dos pedidos',
                    style: kTitleLargeDark,
                  ),
                ),
                Expanded(
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: _showingSections(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildIndicators(),
            ),
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  });

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(text, style: kTitleMedium.copyWith(color: textColor)),
      ],
    );
  }
}

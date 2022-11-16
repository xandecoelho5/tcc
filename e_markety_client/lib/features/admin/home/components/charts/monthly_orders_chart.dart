import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/theme/constants.dart';
import '../../models/monthly_orders.dart';

class MonthlyOrdersChart extends StatefulWidget {
  const MonthlyOrdersChart({
    Key? key,
    required this.monthlyOrders,
  }) : super(key: key);

  final List<MonthlyOrders> monthlyOrders;

  @override
  State<MonthlyOrdersChart> createState() => _MonthlyOrdersChartState();
}

class _MonthlyOrdersChartState extends State<MonthlyOrdersChart> {
  int touchedGroupIndex = -1;
  late double maxY =
      widget.monthlyOrders.map((e) => e.count).reduce(math.max).toDouble();

  List<BarChartGroupData> _barGroups() {
    return widget.monthlyOrders.map((e) {
      final index = widget.monthlyOrders.indexOf(e);
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: e.count.toDouble(),
            color: kPrimaryColor,
            width: 40,
            borderRadius: BorderRadius.zero,
          ),
        ],
        showingTooltipIndicators: touchedGroupIndex == index ? [0] : [],
      );
    }).toList();
  }

  BarTooltipItem _getTooltipItem(
    BarChartGroupData group,
    int groupIndex,
    BarChartRodData rod,
    int rodIndex,
  ) {
    return BarTooltipItem(
      rod.toY.toString(),
      TextStyle(
        fontWeight: FontWeight.bold,
        color: rod.color,
        fontSize: 18,
        shadows: const [Shadow(color: Colors.black26, blurRadius: 12)],
      ),
    );
  }

  AxisTitles _names() {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 32,
        getTitlesWidget: (value, meta) {
          final order = widget.monthlyOrders[value.toInt()];
          return SideTitleWidget(
            axisSide: AxisSide.left,
            child: SizedBox(
              width: 100,
              child: Text(
                '${order.month}/${order.year}',
                style: const TextStyle(
                  color: kBasicDarkColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }

  AxisTitles _sales() {
    return AxisTitles(
      drawBehindEverything: true,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: (value, meta) {
          return Text(
            value.toInt().toString(),
            style: const TextStyle(color: Color(0xFF606060)),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 12, bottom: 16),
              child: Text(
                'Pedidos por mês',
                style: TextStyle(
                  color: kBasicDarkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  borderData: FlBorderData(
                    border: const Border.symmetric(
                      horizontal: BorderSide(color: Color(0xFFececec)),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: _sales(),
                    bottomTitles: _names(),
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: const Color(0xFFececec),
                      strokeWidth: 1,
                    ),
                  ),
                  barGroups: _barGroups(),
                  maxY: maxY,
                  barTouchData: BarTouchData(
                    enabled: true,
                    handleBuiltInTouches: false,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.transparent,
                      tooltipMargin: 0,
                      getTooltipItem: _getTooltipItem,
                    ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response != null &&
                          response.spot != null) {
                        setState(() {
                          touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;
                        });
                      } else {
                        setState(() => touchedGroupIndex = -1);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

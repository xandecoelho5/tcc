import 'dart:math' as math;

import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/products_sales.dart';

class ProductsSalesChart extends StatefulWidget {
  const ProductsSalesChart({
    Key? key,
    required this.productsSales,
    required this.title,
  }) : super(key: key);

  final List<ProductsSales> productsSales;
  final String title;

  @override
  State<ProductsSalesChart> createState() => _ProductsSalesChartState();
}

class _ProductsSalesChartState extends State<ProductsSalesChart> {
  int touchedGroupIndex = -1;
  late double maxY = widget.productsSales.map((e) => e.sales).reduce(math.max);

  List<BarChartGroupData> _barGroups() {
    return widget.productsSales.map((e) {
      final index = widget.productsSales.indexOf(e);
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: e.sales,
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
          return SideTitleWidget(
            axisSide: AxisSide.left,
            child: SizedBox(
              width: 100,
              child: Text(
                widget.productsSales[value.toInt()].name,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 16),
              child: Text(
                widget.title,
                style: const TextStyle(
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

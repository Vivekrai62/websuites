import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:websuites/utils/appColors/app_colors.dart';

class LeadSourceChart extends StatelessWidget {
  final List<SourceData> data = [
    SourceData(source: "Google", count: 11490, color: AllColors.thinPurple),
    SourceData(source: "Bot", count: 4000, color: Colors.orange.shade200),
    SourceData(source: "DirectCall", count: 8000, color: Colors.blue.shade200),
    SourceData(source: "Website", count: 4500, color: Colors.pink.shade200),
    SourceData(source: "OData", count: 3500, color: Colors.blue.shade100),
    SourceData(source: "Reference", count: 9000, color: Colors.orange.shade100),
    SourceData(source: "Facebook", count: 7500, color: Colors.blue.shade300),
    SourceData(
        source: "Offline Event", count: 6500, color: Colors.grey.shade400),
    SourceData(source: "Google", count: 8900, color: Colors.blue.shade200),
    SourceData(source: "Bot", count: 10000, color: Colors.orange.shade200),
    SourceData(source: "DirectCall", count: 3800, color: Colors.green.shade200),
    SourceData(source: "Website", count: 7000, color: Colors.pink.shade200),
    SourceData(source: "OData", count: 9500, color: Colors.blue.shade100),
    SourceData(source: "Facebook", count: 2800, color: Colors.blue.shade300),
  ];

  LeadSourceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Source Wise Count")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AspectRatio(
          aspectRatio: 2.2,
          child: BarChart(
            BarChartData(
              maxY: data
                      .map((e) => e.count.toDouble())
                      .reduce((a, b) => a > b ? a : b) *
                  1.1,
              minY: 0,
              barGroups: data.asMap().entries.map((entry) {
                int index = entry.key;
                SourceData source = entry.value;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: source.count.toDouble(),
                      color: source.color,
                      width: 20,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(13),
                        topRight: Radius.circular(13),
                      ),
                    ),
                  ],
                  showingTooltipIndicators: [0],
                );
              }).toList(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 45,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                              fontSize: 12, color: Colors.green),
                          textAlign: TextAlign.right,
                        ),
                      );
                    },
                  ),
                ),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      if (value.toInt() < 0 || value.toInt() >= data.length) {
                        return Container();
                      }
                      return Transform.rotate(
                        angle: -0.4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            data[value.toInt()].source,
                            style:
                                TextStyle(fontSize: 10, color: AllColors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                drawHorizontalLine: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: value == 0 ? Colors.black : Colors.transparent,
                    strokeWidth: value == 0 ? 1 : 0,
                  );
                },
              ),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (group) => Colors.transparent,
                  tooltipPadding: EdgeInsets.zero,
                  tooltipMargin: 0,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      rod.toY.toInt().toString(),
                      const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SourceData {
  final String source;
  final int count;
  final Color color;

  SourceData({required this.source, required this.count, required this.color});
}

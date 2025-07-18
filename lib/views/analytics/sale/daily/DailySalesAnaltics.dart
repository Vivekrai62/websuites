import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:websuites/utils/fontfamily/FontFamily.dart';

import '../../../../utils/dark_mode/dark_mode.dart';
import '../../../../utils/datetrim/DateTrim.dart';
import '../../../../viewModels/analytics/sale_analytics/DailyAnalyticsViewModel.dart';

class DailySalesAnalytics extends StatefulWidget {
  const DailySalesAnalytics({super.key});

  @override
  State<DailySalesAnalytics> createState() => _DailySalesAnalyticsState();
}

class _DailySalesAnalyticsState extends State<DailySalesAnalytics> {
  final controller = Get.put(DailyAnalyticsViewModel());

  @override
  void initState() {
    super.initState();
    controller.dailyAnalyticsListApi(context);
  }

// Function to format the number with "K"

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double chartHeight = screenHeight * 0.4;

    return Obx(() {
      List<LeadData> leadData = [
        LeadData('Approved', controller.approvedAmount?.toDouble() ?? 0,
            AllColors.darkGreen),
        LeadData('Pending', 48, AllColors.vividRed), // Static value for now
        LeadData('Total Order', controller.totalOrders?.toDouble() ?? 0,
            AllColors.darkPink),
        LeadData('Total Amount', controller.totalAmount?.toDouble() ?? 0,
            AllColors.mediumPurple),
      ];

      double maxY = 0;
      for (var data in leadData) {
        if (data.value > maxY) {
          maxY = data.value;
        }
      }
      maxY = maxY <= 1000
          ? ((maxY + 200) ~/ 100) * 100.0
          : ((maxY + 1000) ~/ 1000) * 1000.0;

      double interval = maxY <= 1000
          ? 200
          : maxY <= 5000
              ? 1000
              : 2000;

      String formatYAxisValue(double value) {
        if (value >= 1000) {
          return '${(value / 1000).toStringAsFixed(0)}K'; // Format as "1K", "2K", etc.
        }
        return value.toString(); // Return as is for values less than 1000
      }

      return Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ContainerUtils(
                  // alignment: Alignment.center,
                  // padding: const EdgeInsets.all(15),
                  // decoration: BoxDecoration(
                  //   color: DarkMode.backgroundColor(context),
                  //   borderRadius: BorderRadius.circular(8.0),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.grey.withOpacity(0.2),
                  //       blurRadius: 8.0,
                  //       spreadRadius: 2.0,
                  //     ),
                  //   ],
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Daily Sales Report',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.bar_chart,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      // Legend
                      Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 6,
                                  backgroundColor: AllColors.greenJungle),
                              const SizedBox(width: 5),
                              const Text("Approved Amount",
                                  style: TextStyle(
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 12)),
                              const Spacer(),
                              CircleAvatar(
                                  radius: 6,
                                  backgroundColor: AllColors.vividRed),
                              const SizedBox(width: 5),
                              const Text("Pending Amount",
                                  style: TextStyle(
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 6,
                                  backgroundColor: AllColors.darkPink),
                              const SizedBox(width: 5),
                              const Text("Total Order",
                                  style: TextStyle(
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 12)),
                              const Spacer(),
                              CircleAvatar(
                                  radius: 6,
                                  backgroundColor: AllColors.mediumPurple),
                              const SizedBox(width: 5),
                              const Text("Total Amount",
                                  style: TextStyle(
                                      fontFamily: FontFamily.sfPro,
                                      fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ContainerUtils(
                  // alignment: Alignment.center,
                  // padding: const EdgeInsets.all(15),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(8.0),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.grey.withOpacity(0.2),
                  //       blurRadius: 8.0,
                  //       spreadRadius: 2.0,
                  //     ),
                  //   ],
                  // ),
                  child: SizedBox(
                    height: chartHeight,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: maxY,
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                '${leadData[groupIndex].value}',
                                const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: FontFamily.sfPro,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(top: 7, left: 2),
                                  child: Text(
                                    leadData[value.toInt()].name,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              },
                              reservedSize: 40,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 34,
                              interval: interval,
                              getTitlesWidget: (value, meta) {
                                // Only show labels at interval points
                                if (value == 0 ||
                                    value.remainder(interval) == 0) {
                                  return Text(
                                    formatYAxisValue(value),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: interval / 10,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey.withOpacity(0.12),
                              strokeWidth: value % interval == 1 ? 0.8 : 1,
                            );
                          },
                          checkToShowHorizontalLine: (value) {
                            return value >= 0 && value <= maxY;
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: leadData.asMap().entries.map((entry) {
                          return BarChartGroupData(
                            x: entry.key,
                            barRods: [
                              BarChartRodData(
                                toY: entry.value.value,
                                color: entry.value.color,
                                width: 20,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(3),
                                  topRight: Radius.circular(3),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ContainerUtils(
                  // alignment: Alignment.center,
                  // padding: const EdgeInsets.all(15),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(8.0),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.grey.withOpacity(0.2),
                  //       blurRadius: 8.0,
                  //       spreadRadius: 2.0,
                  //     ),
                  //   ],
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.name.toString() ?? 'N/A',
                              style: const TextStyle(
                                  fontFamily: FontFamily.sfPro,
                                  fontWeight: FontWeight.w600)),
                          const Spacer(),
                          Icon(Icons.auto_graph_sharp,
                              color: AllColors.mediumPurple, size: 20)
                        ],
                      ),
                      const SizedBox(height: 3),
                      const Divider(thickness: 0.4),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 6,
                              backgroundColor: AllColors.greenJungle),
                          const SizedBox(width: 5),
                          const Text("Approved Amount",
                              style: TextStyle(
                                  fontFamily: FontFamily.sfPro, fontSize: 12)),
                          const SizedBox(width: 5),
                          Text(
                            formatNumberWithK(
                                controller.approvedAmount?.toDouble() ??
                                    0), // Cast to double
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: FontFamily.sfPro,
                                fontSize: 12),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 6, backgroundColor: AllColors.vividRed),
                          const SizedBox(width: 5),
                          const Text("Pending Amount",
                              style: TextStyle(
                                  fontFamily: FontFamily.sfPro, fontSize: 12)),
                          const SizedBox(width: 5),
                          Text(
                            (controller.totalAmount != null &&
                                    controller.approvedAmount != null)
                                ? formatNumberWithK((controller.totalAmount! -
                                        controller.approvedAmount!)
                                    .toDouble())
                                : "0",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: FontFamily.sfPro,
                                fontSize: 12),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 6, backgroundColor: AllColors.darkPink),
                          const SizedBox(width: 5),
                          const Text("Total Orders",
                              style: TextStyle(
                                  fontFamily: FontFamily.sfPro, fontSize: 12)),
                          const SizedBox(width: 5),
                          Text(
                            formatNumberWithK(
                                controller.totalOrders?.toDouble() ??
                                    0), // Apply the K format
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: FontFamily.sfPro,
                                fontSize: 12),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 6,
                              backgroundColor: AllColors.mediumPurple),
                          const SizedBox(width: 5),
                          const Text("Total Amount",
                              style: TextStyle(
                                  fontFamily: FontFamily.sfPro, fontSize: 12)),
                          const SizedBox(width: 5),
                          Text(
                            formatNumberWithK(
                                controller.totalAmount?.toDouble() ??
                                    0), // Apply the K format
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: FontFamily.sfPro,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class LeadData {
  final String name;
  final double value;
  final Color color;

  const LeadData(this.name, this.value, this.color);
}

// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/image_constants.dart';
import 'package:bill_sync_app/services/get_request_service.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String selected = "All Vendors";
  bool isLoading = false;
  dynamic dashboardData = {};
  List vendorsList = [];
  bool _isLoading = false;
  List<dynamic> inventoryData = [];

  // List<double> values = [];
  // List<String> labels = [];

  final List<double> values = [70, 50, 55, 40, 58, 50];
  final List<String> labels = [
    "Emerald",
    "Ruby",
    "Polki",
    "Pearl",
    "Ruby\nMani",
    "Emerald\nMani",
  ];

  @override
  void initState() {
    getDashboardData();
    super.initState();
  }

  getDashboardData() async {
    setState(() {
      _isLoading = false;
    });
    dashboardData = await GetRequestServices().getDashboardData(
      context: context,
    );
    setState(() {
      inventoryData = dashboardData['inventoryChart'];
      // for (var item in inventoryData) {
      //   labels.add(item['name']);
      //   values.add((item['totalInverntory'] ?? 0).toDouble());
      // }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(26),
                      bottomRight: Radius.circular(26),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: Platform.isIOS ? 0 : 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppText(
                                text: 'Hello, Yashwant',
                                fontsize: 22,
                                fontWeight: FontWeight.bold,
                                textColor: AppColor.white,
                                // textColor: AppColor.textBlack,
                              ),
                              AppText(
                                text: 'Welcome to BillSync',
                                fontsize: 15,
                                fontWeight: FontWeight.w500,
                                textColor: Colors.white70,
                                // textColor: AppColor.secondary,
                                fontfamily: GoogleFonts.roboto().fontFamily,
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(ImageConstant.menAvatar4),
                            // backgroundImage: AssetImage(ImageConstant.femaleAvatar),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 140,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.symmetric(horizontal: 18.0),
                      height: 210,
                      width: 360,
                      decoration: BoxDecoration(
                        color: AppColor.lightPrimary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _buildInvoicesLineChart(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 200),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "Inventory",
                        fontsize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      InkWell(
                        onTap: () {},
                        child: AppText(
                          text: "View all",
                          fontsize: 16,
                          fontWeight: FontWeight.w600,
                          textColor: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                  appSpaces.spaceForHeight20,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _buildInventoryBarChart(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoicesLineChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Total Invoice",
                    fontsize: 14,
                    textColor: AppColor.textDarkGreyColor,
                  ),
                  SizedBox(height: 2),
                  AppText(
                    text: "25",
                    fontsize: 24,
                    fontWeight: FontWeight.w600,
                    textColor: AppColor.textBlack,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.white,
                ),
                child: Row(
                  children: [
                    AppText(
                      text: "This week",
                      fontsize: 14,
                      textColor: AppColor.textBlack,
                      fontWeight: FontWeight.w600,
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 25),
        SizedBox(
          height: 90,
          child: LineChart(
            LineChartData(
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 2),
                    FlSpot(1, 1.3),
                    FlSpot(2, 2.2),
                    FlSpot(3, 1.5),
                    FlSpot(4, 2.8),
                    FlSpot(5, 2.2),
                    FlSpot(6, 3.0),
                    FlSpot(7, 1.2),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 1.2,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.blue.withOpacity(0.3),
                  ),
                  dotData: FlDotData(
                    show: true,
                    checkToShowDot: (spot, _) => spot.x == 4,
                    getDotPainter: (spot, percent, bar, index) {
                      return FlDotCirclePainter(
                        radius: 5,
                        color: Colors.white,
                        strokeWidth: 3,
                        strokeColor: Colors.blue,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInventoryBarChart() {
    return AspectRatio(
      aspectRatio: 1.4,
      child: BarChart(
        BarChartData(
          groupsSpace: 40,
          alignment: BarChartAlignment.spaceEvenly,
          // maxY: values.isNotEmpty ? (values.reduce((a, b) => a > b ? a : b) + 10) : 100,
          maxY: 100,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 20,
                getTitlesWidget: (double value, TitleMeta meta) {
                  // if (value % 20 == 0) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                  // }
                  // return Container();
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return SideTitleWidget(
                    meta: TitleMeta(
                      min: 20,
                      max: 20,
                      parentAxisSize: 100,
                      axisPosition: 0,
                      appliedInterval: 0,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35,
                      ),
                      formattedValue: "",
                      axisSide: meta.axisSide,
                      rotationQuarterTurns: 0,
                    ),
                    space: 4,
                    child: AppText(
                      text: labels.length > value.toInt() ? labels[value.toInt()] : '',
                      // text: labels[value.toInt()],
                      fontsize: 10,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups:
              values.asMap().entries.map((entry) {
                int index = entry.key;
                double height = entry.value;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: height,
                      width: 24,
                      borderRadius: BorderRadius.circular(4),
                      rodStackItems: [],
                      color: AppColor.primary,
                      backDrawRodData: BackgroundBarChartRodData(
                        toY: 100,
                        color: Colors.grey.shade300,
                        show: true,
                      ),
                    ),
                  ],
                );
              }).toList(),
          gridData: FlGridData(show: false),
        ),
      ),
    );
  }
}



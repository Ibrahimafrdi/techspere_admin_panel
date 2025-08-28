import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/decorations.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomerStatsGraph extends StatelessWidget {
  const CustomerStatsGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: primaryDecoration.copyWith(color: Colors.white),
      height: 400,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: 'Customer Stats'.customText(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black45,
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SfCartesianChart(
                primaryYAxis: NumericAxis(isVisible: false),
                plotAreaBorderWidth: 0,
                primaryXAxis: CategoryAxis(
                  tickPosition: TickPosition.outside,
                  labelPlacement: LabelPlacement.betweenTicks,
                  labelStyle: TextStyle(fontSize: 10),
                  maximumLabels: 5,
                  arrangeByIndex: true,
                  majorGridLines: MajorGridLines(color: Colors.transparent),
                ),
                series: <CartesianSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    // borderColor: Color.fromARGB(255, 236, 151, 48),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 173, 72),
                        Color.fromARGB(255, 255, 212, 160),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(7),
                    ),
                    dataSource: List.generate(
                      24,
                      (index) => ChartData(
                        '${(index + 1).toString().padLeft(2, '0')}:00',
                        Random().nextDouble() * 100,
                      ),
                    ),
                    xValueMapper: (ChartData data, _) => data.hour,
                    yValueMapper: (ChartData data, _) => data.y,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.hour, this.y);
  final String hour;
  final double y;
}

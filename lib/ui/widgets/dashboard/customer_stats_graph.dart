import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/decorations.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/ui/screens/dashboard/dashboard_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomerStatsGraph extends StatelessWidget {
  final List<CustomerData> data;
  
  const CustomerStatsGraph({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Convert CustomerData to ChartData for the chart
    final chartData = data.map((item) => ChartData(item.hour, item.count)).toList();

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
              child: data.isEmpty
                  ? Center(
                      child: 'No customer data available'.customText(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    )
                  : SfCartesianChart(
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
                          dataSource: chartData,
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
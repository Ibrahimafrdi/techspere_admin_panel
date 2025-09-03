import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/decorations.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/ui/screens/dashboard/dashboard_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesSummaryGraph extends StatelessWidget {
  final List<SalesData> salesData;
  final double totalSales;
  final double avgSalesPerDay;

  const SalesSummaryGraph({
    super.key,
    required this.salesData,
    required this.totalSales,
    required this.avgSalesPerDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: primaryDecoration.copyWith(color: Colors.white),
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                'Sales Summary'.customText(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.bar_chart_outlined,
                                color: Colors.black45,
                              ),
                              SizedBox(width: 10),
                              'Rs. ${totalSales.toStringAsFixed(0)}'.customText(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          'Total Sales'.customText(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.bar_chart_outlined,
                                color: Colors.black45,
                              ),
                              SizedBox(width: 10),
                              'Rs. ${avgSalesPerDay.toStringAsFixed(0)}'.customText(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          'Average Sales Per Day'.customText(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: salesData.isEmpty
                        ? Center(
                            child: 'No sales data available'.customText(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          )
                        : SfCartesianChart(
                            primaryYAxis: NumericAxis(isVisible: false),
                            plotAreaBorderWidth: 0,
                            primaryXAxis: CategoryAxis(
                              tickPosition: TickPosition.outside,
                              labelPlacement: LabelPlacement.onTicks,
                              maximumLabels: 5,
                              arrangeByIndex: true,
                              axisLine: AxisLine(color: Colors.transparent),
                              majorGridLines: MajorGridLines(color: Colors.transparent),
                            ),
                            series: <SplineAreaSeries<SalesData, String>>[
                              SplineAreaSeries<SalesData, String>(
                                borderColor: Color.fromARGB(255, 236, 151, 48),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 255, 191, 112),
                                    Colors.white,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                dataSource: salesData,
                                xValueMapper: (SalesData sales, _) => sales.date,
                                yValueMapper: (SalesData sales, _) => sales.sales,
                              )
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
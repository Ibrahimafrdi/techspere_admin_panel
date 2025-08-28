import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import 'package:kabir_admin_panel/core/constants/decorations.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrderSummaryGraph extends StatelessWidget {
  OrderSummaryGraph({super.key});

  final List<ChartData> chartData = [
    ChartData('Delivered', 50, deliveredOrderColor),
    ChartData('Returned', 10, returnedOrderColor),
    ChartData('Canceled', 20, Colors.purple),
    ChartData('Rejected', 20, rejectedOrderColor),
  ];

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
                'Order Summary'.customText(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SfCircularChart(
                  series: <CircularSeries>[
                    // Renders radial bar chart
                    RadialBarSeries<ChartData, String>(
                      gap: '13%',
                      radius: '70%',
                      dataSource: chartData,
                      cornerStyle: CornerStyle.bothCurve,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      pointColorMapper: (ChartData data, index) => data.color,
                      useSeriesColor: true,
                      trackOpacity: 0.1,
                      sortingOrder: SortingOrder.ascending,
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      chartData.length,
                      (index) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          '${chartData[index].x} (${chartData[index].y}%)'
                              .customText(),
                          Container(
                            height: 7,
                            decoration: BoxDecoration(
                              color: chartData[index].color,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

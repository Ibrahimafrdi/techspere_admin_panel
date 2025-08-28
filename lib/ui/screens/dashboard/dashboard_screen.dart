import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/ui/widgets/dashboard/customer_stats_graph.dart';
import 'package:kabir_admin_panel/ui/widgets/dashboard/featured_items_grid.dart';
import 'package:kabir_admin_panel/ui/widgets/dashboard/order_stats_grid.dart';
import 'package:kabir_admin_panel/ui/widgets/dashboard/order_summary_graph.dart';
import 'package:kabir_admin_panel/ui/widgets/dashboard/overview_grid.dart';
import 'package:kabir_admin_panel/ui/widgets/dashboard/popular_items_grid.dart';
import 'package:kabir_admin_panel/ui/widgets/dashboard/sales_summary_graph.dart';
import 'package:kabir_admin_panel/ui/widgets/dashboard/top_customers_grid.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Overview'.customText(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 10),
          //                                                 OVERVIEW GRID
          OverviewGrid(),
          //                                              --------------------
          SizedBox(height: 50),
          'Order Statistics'.customText(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 10),
          //                                                 ORDER STATISTICS
          OrderStatsGrid(),
          //                                              --------------------
          SizedBox(height: 50),

          GridView.builder(
            itemCount: 6,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 400,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (context, index) => graphs[index],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  var graphs = [
    SalesSummaryGraph(),
    OrderSummaryGraph(),
    CustomerStatsGraph(),
    TopCustomersGrid(),
    FeaturedItemsGrid(),
    PopularItemsGrid(),
  ];
}

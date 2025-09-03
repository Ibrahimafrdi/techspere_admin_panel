import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/ui/screens/dashboard/dashboard_provider.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider(
      create: (context) => DashboardProvider(),
      child: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
          if (dashboardProvider.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  'Loading Dashboard...'.customText(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: dashboardProvider.refreshData,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Overview'.customText(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      IconButton(
                        onPressed: dashboardProvider.refreshData,
                        icon: Icon(Icons.refresh),
                        tooltip: 'Refresh Dashboard',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //                                                 OVERVIEW GRID
                  OverviewGrid(stats: dashboardProvider.dashboardStats),
                  //                                              --------------------
                  SizedBox(height: 50),
                  'Order Statistics'.customText(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 10),
                  //                                                 ORDER STATISTICS
                  OrderStatsGrid(stats: dashboardProvider.dashboardStats),
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
                    itemBuilder: (context, index) => _buildGraphWidget(index, dashboardProvider),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGraphWidget(int index, DashboardProvider provider) {
    switch (index) {
      case 0:
        return SalesSummaryGraph(
          salesData: provider.salesData,
          totalSales: provider.dashboardStats['totalSales'] ?? 0.0,
          avgSalesPerDay: provider.dashboardStats['avgSalesPerDay'] ?? 0.0,
        );
      case 1:
        return OrderSummaryGraph(data: provider.orderSummaryData);
      case 2:
        return CustomerStatsGraph(data: provider.customerData);
      case 3:
        return TopCustomersGrid(customers: provider.users);
      case 4:
        return FeaturedItemsGrid(items: provider.dashboardStats['featuredItems'] ?? []);
      case 5:
        return PopularItemsGrid(items: provider.dashboardStats['popularItems'] ?? []);
      default:
        return SizedBox();
    }
  }
}
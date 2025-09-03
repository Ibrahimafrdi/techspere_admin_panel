import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import 'package:kabir_admin_panel/core/constants/decorations.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';

class OverviewGrid extends StatelessWidget {
  final Map<String, dynamic> stats;
  
  OverviewGrid({super.key, required this.stats});

  final colors = [
    primaryColor,
    Colors.indigo,
    Colors.blue,
    Colors.purple,
  ];

  final icons = [
    Icons.monetization_on,
    Icons.shopping_cart,
    Icons.people,
    Icons.inventory,
  ];

  @override
  Widget build(BuildContext context) {
    final overviewData = [
      {
        'title': 'Total Sales',
        'value': 'Rs. ${(stats['totalSales'] ?? 0.0).toStringAsFixed(0)}',
        'icon': Icons.monetization_on,
        'color': colors[0],
      },
      {
        'title': 'Total Orders',
        'value': '${stats['totalOrders'] ?? 0}',
        'icon': Icons.shopping_cart,
        'color': colors[1],
      },
      {
        'title': 'Total Customers',
        'value': '${stats['totalCustomers'] ?? 0}',
        'icon': Icons.people,
        'color': colors[2],
      },
      {
        'title': 'Total Items',
        'value': '${stats['totalItems'] ?? 0}',
        'icon': Icons.inventory,
        'color': colors[3],
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      itemCount: overviewData.length,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 90,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        final data = overviewData[index];
        return Container(
          decoration: primaryDecoration.copyWith(color: data['color'] as Color),
          alignment: Alignment.topCenter,
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    data['icon'] as IconData,
                    color: data['color'] as Color,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['title'] as String,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      data['value'] as String,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
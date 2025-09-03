import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import '../../../core/constants/decorations.dart';

class OrderStatsGrid extends StatelessWidget {
  final Map<String, dynamic> stats;
  
  OrderStatsGrid({super.key, required this.stats});

  final colors = [
    totalOrderColor,
    pendingOrderColor,
    processingOrderColor,
    outForDeliveryOrderColor,
    deliveredOrderColor,
    canceledOrderColor,
    returnedOrderColor,
    rejectedOrderColor,
  ];

  final titles = [
    'Total Orders',
    'Pending',
    'Processing',
    'Out For Delivery',
    'Delivered',
    'Canceled',
    'Returned',
    'Rejected',
  ];

  final icons = [
    Icons.local_shipping,
    Icons.pending_actions,
    Icons.hourglass_empty,
    Icons.delivery_dining,
    Icons.check_circle,
    Icons.cancel,
    Icons.keyboard_return,
    Icons.block,
  ];

  @override
  Widget build(BuildContext context) {
    final orderStatsData = [
      {
        'title': titles[0],
        'value': '${stats['totalOrders'] ?? 0}',
        'icon': icons[0],
        'color': colors[0],
      },
      {
        'title': titles[1],
        'value': '${stats['pendingOrders'] ?? 0}',
        'icon': icons[1],
        'color': colors[1],
      },
      {
        'title': titles[2],
        'value': '${stats['processingOrders'] ?? 0}',
        'icon': icons[2],
        'color': colors[2],
      },
      {
        'title': titles[3],
        'value': '${stats['outForDeliveryOrders'] ?? 0}',
        'icon': icons[3],
        'color': colors[3],
      },
      {
        'title': titles[4],
        'value': '${stats['deliveredOrders'] ?? 0}',
        'icon': icons[4],
        'color': colors[4],
      },
      {
        'title': titles[5],
        'value': '${stats['canceledOrders'] ?? 0}',
        'icon': icons[5],
        'color': colors[5],
      },
      {
        'title': titles[6],
        'value': '${stats['returnedOrders'] ?? 0}',
        'icon': icons[6],
        'color': colors[6],
      },
      {
        'title': titles[7],
        'value': '${stats['rejectedOrders'] ?? 0}',
        'icon': icons[7],
        'color': colors[7],
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      itemCount: orderStatsData.length,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 90,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        final data = orderStatsData[index];
        return Container(
          decoration: primaryDecoration.copyWith(color: Colors.white),
          alignment: Alignment.topCenter,
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  backgroundColor: (data['color'] as Color).withOpacity(0.1),
                  child: Icon(
                    data['icon'] as IconData,
                    color: data['color'] as Color,
                    size: 20,
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
                        color: Colors.black45,
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
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
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
import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';

import '../../../core/constants/decorations.dart';

class OrderStatsGrid extends StatelessWidget {
  OrderStatsGrid({super.key});

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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 8,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 90,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: primaryDecoration.copyWith(color: Colors.white),
          alignment: Alignment.topCenter,
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  backgroundColor: colors[index].withOpacity(0.1),
                  child: Icon(
                    Icons.local_shipping,
                    color: colors[index],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  titles[index].customText(
                    color: Colors.black45,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  '8'.customText(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

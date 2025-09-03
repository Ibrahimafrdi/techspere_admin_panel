import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/data_providers/orders_provider.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/data_grid.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/header/outlined_button.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/decorations.dart';

class SalesReportScreen extends StatelessWidget {
  const SalesReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersProvider>(builder: (context, ordersProvider, child) {
      return Container(
        decoration: primaryDecoration.copyWith(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  'Sales Report'.customText(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: DataGrid(
                columnNames: [
                  'order id',
                  'date',
                  'total',
                  'discount',
                  'delivery charge',
                  'payment status',
                ],
                records: ordersProvider.orders
                    .map(
                      (order) => [
                        order.id,
                        order.createdAt != null
                            ? DateFormat('yyyy-MM-dd').format(order.createdAt!)
                            : 'N/A',
                        order.total != null
                            ? '\$${order.total!.toStringAsFixed(2)}'
                            : 'N/A',
                        order.discount != null
                            ? '\$${order.discount!.toStringAsFixed(2)}'
                            : 'N/A',
                        order.deliveryCharges != null
                            ? '\$${order.deliveryCharges!.toStringAsFixed(2)}'
                            : 'N/A',
                        'Paid',
                      ],
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      );
    });
  }
}

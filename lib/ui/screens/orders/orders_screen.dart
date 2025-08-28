import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/data_providers/orders_provider.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/core/models/action.dart';
import 'package:kabir_admin_panel/ui/routing/app_router.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/data_grid.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/header/outlined_button.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/decorations.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersProvider>(builder: (context, ordersProvider, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                      'Orders'.customText(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black45,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BorderedButton(
                            text: 'Filter',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          BorderedButton(
                            text: 'Export',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                DataGrid(
                  columnNames: [
                    'order id',
                    'customer',
                    'amount',
                    'status',
                    'action',
                  ],
                  records: ordersProvider.orders
                      .map(
                        (order) => [
                          order.id,
                          order.userName,
                          order.total.toString(),
                          order.status,
                          [
                            ActionModel(
                              text: onlyViewActionString,
                              onTap: () {
                                appRouter.go('/online-orders/view',
                                    extra: order.id);
                              },
                            ),
                          ]
                        ],
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

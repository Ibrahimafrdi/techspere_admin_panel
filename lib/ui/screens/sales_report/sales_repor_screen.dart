import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/data_grid.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/header/outlined_button.dart';

import '../../../core/constants/decorations.dart';

class SalesReportScreen extends StatelessWidget {
  const SalesReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    'Sales Report'.customText(
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
                  'date',
                  'total',
                  'discount',
                  'delivery charge',
                  'payment status',
                ],
                records: [
                  [
                    '10001',
                    '11:24 AM, 02-10-2024',
                    '8.50',
                    '0.00',
                    '0.00',
                    paidString,
                  ],
                  [
                    '10002',
                    '11:24 AM, 02-10-2024',
                    '8.50',
                    '0.00',
                    '0.00',
                    unPaidString,
                  ],
                  [
                    '10003',
                    '11:24 AM, 02-10-2024',
                    '8.50',
                    '0.00',
                    '0.00',
                    paidString,
                  ],
                  [
                    '10004',
                    '11:24 AM, 02-10-2024',
                    '8.50',
                    '0.00',
                    '0.00',
                    paidString,
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

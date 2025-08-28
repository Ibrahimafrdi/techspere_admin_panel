import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/data_grid.dart';

import '../../../core/constants/decorations.dart';
import '../../widgets/common/data_grid/header/outlined_button.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

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
                    'Customers'.customText(
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
                  'name',
                  'email',
                  'phone',
                  'status',
                  'action',
                ],
                records: [
                  [
                    'John Doe',
                    'admin@example.com',
                    '+8801254875855',
                    activeString,
                    allActionsString,
                  ],
                  [
                    'John Doe',
                    'admin@example.com',
                    '+8801254875855',
                    activeString,
                    allActionsString,
                  ],
                  [
                    'John Doe',
                    'admin@example.com',
                    '+8801254875855',
                    activeString,
                    allActionsString,
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

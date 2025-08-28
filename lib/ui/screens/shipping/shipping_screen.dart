import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/data_providers/shippings_provider.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/core/models/action.dart';
import 'package:kabir_admin_panel/ui/screens/shipping/shipping_edit_dialog.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/data_grid.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/header/add_button.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/header/outlined_button.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/decorations.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShippingsProvider>(
      builder: (context, shippingsProvider, child) {
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
                    'Shipping Areas'.customText(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BorderedButton(
                          text: 'Import',
                        ),
                        SizedBox(width: 10),
                        BorderedButton(
                          text: 'Export',
                        ),
                        SizedBox(width: 10),
                        AddButton(
                          text: 'Add Shipping Area',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ShippingEditDialog();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: DataGrid(
                  columnNames: [
                    'area name',
                    'delivery charge',
                    'status',
                    'action',
                  ],
                  records: shippingsProvider.shippings.map(
                    (shipping) {
                      return [
                        shipping.areaName ?? '',
                        '\$${shipping.deliveryCharge?.toStringAsFixed(2)}',
                        (shipping.isAvailable ?? true)
                            ? activeString
                            : inActiveString,
                        [
                          ActionModel(
                            text: onlyEditActionString,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ShippingEditDialog(
                                    shippingModel: shipping,
                                  );
                                },
                              );
                            },
                          ),
                          ActionModel(
                            text: onlyDeleteActionString,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Confirm Delete'),
                                  content: Text(
                                    'Are you sure you want to delete this shipping area?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        shippingsProvider
                                            .deleteShipping(shipping.id!);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ];
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

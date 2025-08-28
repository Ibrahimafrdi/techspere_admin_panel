import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/data_providers/addons_provider.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/core/models/action.dart';
import 'package:kabir_admin_panel/ui/screens/addons/addon_edit_dialog.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/data_grid.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/header/add_button.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/header/outlined_button.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/decorations.dart';

class AddonsScreen extends StatelessWidget {
  const AddonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddonsProvider>(builder: (context, model, child) {
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
                  'Addons'.customText(
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
                        text: 'Import',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      BorderedButton(
                        text: 'Export',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      AddButton(
                        text: 'Add Addon',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddonEditDialog();
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
                  'name',
                  'price',
                  'status',
                  'action',
                ],
                records: model.addons.map(
                  (addon) {
                    return [
                      addon.name,
                      addon.price,
                      (addon.isAvailable ?? true)
                          ? activeString
                          : inActiveString,
                      [
                        ActionModel(
                          text: onlyEditActionString,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddonEditDialog(
                                  addonModel: addon,
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
                                    'Are you sure you want to delete this Addon?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      model.deleteAddon(addon.id!);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ]
                    ];
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }
}

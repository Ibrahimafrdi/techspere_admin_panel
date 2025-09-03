import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/data_providers/categories_provider.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/core/models/action.dart';
import 'package:kabir_admin_panel/ui/screens/categories/category_edit_dialog.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/data_grid.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/header/add_button.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/header/outlined_button.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/decorations.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
        builder: (context, categoriesProvider, child) {
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
                  'Categories'.customText(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      AddButton(
                        text: 'Add Category',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CategoryEditDialog();
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
                  'status',
                  'action',
                ],
                records: categoriesProvider.categories.map(
                  (category) {
                    return [
                      category.name ?? '',
                      (category.isAvailable ?? true)
                          ? activeString
                          : inActiveString,
                      [
                        ActionModel(
                          text: onlyEditActionString,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CategoryEditDialog(
                                  categoryModel: category,
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
                                    'Are you sure you want to delete this Category?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      categoriesProvider
                                          .deleteCategory(category.id!);
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
    });
  }
}

import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/data_providers/categories_provider.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/core/models/action.dart';
import 'package:kabir_admin_panel/ui/routing/app_router.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/data_grid.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/decorations.dart';
import '../../../core/data_providers/items_provider.dart';
import '../../widgets/common/data_grid/header/add_button.dart';
import '../../widgets/common/data_grid/header/outlined_button.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  static const List<String> _columnNames = [
    'name',
    'category',
    'price',
    'status',
    'action'
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<ItemsProvider, CategoriesProvider>(
      builder: (context, itemsProvider, categoriesProvider, child) {
        return Container(
          decoration: primaryDecoration.copyWith(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const FoodScreenHeader(),
              const Divider(),
              Expanded(
                child: DataGrid(
                  columnNames: _columnNames,
                  records: itemsProvider.items
                      .map(
                        (item) => [
                          item.title,
                          categoriesProvider.categories
                              .firstWhere(
                                  (category) => category.id == item.categoryId)
                              .name,
                          item.price.toString(),
                          (item.isAvailable ?? true)
                              ? activeString
                              : inActiveString,
                          [
                            ActionModel(
                              text: onlyEditActionString,
                              onTap: () {
                                appRouter.go('/item/edit', extra: item);
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
                                        'Are you sure you want to delete this item?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          itemsProvider.deleteItem(item.id!);
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
                        ],
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<List<String>> _getSampleFoodData() {
    // This method could be moved to a separate file or service class
    return [
      ['Soda (Can)', 'Beverages', '50', activeString, allActionsString],
      ['Mojito', 'Beverages', '50', activeString, allActionsString],
      ['Mojito', 'Beverages', '50', activeString, allActionsString],
      ['Mojito', 'Beverages', '50', activeString, allActionsString],
      ['Mojito', 'Beverages', '50', activeString, allActionsString],
      ['Mojito', 'Beverages', '50', activeString, allActionsString],
      ['Mojito', 'Beverages', '50', activeString, allActionsString],
      ['Mojito', 'Beverages', '50', activeString, allActionsString],
      ['Iced Coffee', 'Beverages', '50', inActiveString, allActionsString],
      ['Iced Coffee', 'Beverages', '50', inActiveString, allActionsString],
      ['Iced Coffee', 'Beverages', '50', inActiveString, allActionsString],
      ['Iced Coffee', 'Beverages', '50', inActiveString, allActionsString],
      ['Iced Coffee', 'Beverages', '50', inActiveString, allActionsString],
      ['Iced Coffee', 'Beverages', '50', inActiveString, allActionsString],
      ['Iced Coffee', 'Beverages', '50', inActiveString, allActionsString],
      ['Iced Coffee', 'Beverages', '50', inActiveString, allActionsString],
      ['Iced Coffee', 'Beverages', '50', inActiveString, allActionsString],
      ['Iced Coffee', 'Beverages', '50', inActiveString, allActionsString],
    ];
  }
}

class FoodScreenHeader extends StatelessWidget {
  const FoodScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          'Foods'.customText(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black45,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 10),
              AddButton(
                text: 'Add Item',
                onTap: () {
                  appRouter.go('/item/add');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

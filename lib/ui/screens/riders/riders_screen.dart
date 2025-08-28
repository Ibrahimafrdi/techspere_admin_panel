import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/data_providers/riders_provider.dart';
import 'package:kabir_admin_panel/core/models/action.dart';
import 'package:provider/provider.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/core/services/database_services.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/data_grid.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/header/add_button.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/header/outlined_button.dart';
import 'package:kabir_admin_panel/ui/widgets/riders/add_rider_dialog.dart';
import '../../../core/constants/decorations.dart';

class RidersScreen extends StatelessWidget {
  const RidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RidersProvider>(
      builder: (context, ridersProvider, child) {
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        'Riders'.customText(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black45,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const BorderedButton(
                              text: 'Filter',
                            ),
                            const SizedBox(width: 10),
                            const BorderedButton(
                              text: 'Export',
                            ),
                            const SizedBox(width: 10),
                            AddButton(
                              text: 'Add Rider',
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AddRiderDialog(),
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  DataGrid(
                    columnNames: const [
                      'name',
                      'email',
                      'phone',
                      'status',
                      'action',
                    ],
                    records: ridersProvider.riders
                        .map((rider) => [
                              rider.name,
                              rider.email,
                              rider.phone,
                              rider.isActive == true
                                  ? activeString
                                  : inActiveString,
                              [
                                ActionModel(
                                  text: onlyViewActionString,
                                  onTap: () {},
                                ),
                                ActionModel(
                                  text: onlyDeleteActionString,
                                  onTap: () {},
                                ),
                              ],
                            ])
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/models/addon.dart';
import 'package:kabir_admin_panel/ui/screens/addons/addons_screen_provider.dart';
import 'package:kabir_admin_panel/ui/widgets/common/add_or_edit_dialog.dart';
import 'package:kabir_admin_panel/ui/widgets/common/custom_radio.dart';
import 'package:kabir_admin_panel/ui/widgets/common/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddonEditDialog extends StatefulWidget {
  final Addon? addonModel;

  const AddonEditDialog({super.key, this.addonModel});

  @override
  State<AddonEditDialog> createState() => _AddonEditDialogState();
}

class _AddonEditDialogState extends State<AddonEditDialog> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddonsScreenProvider(),
      child: Consumer<AddonsScreenProvider>(builder: (context, model, child) {
        if (widget.addonModel != null) {
          model.initAddon(widget.addonModel!);
        }
        return AddOrEditDialog(
          title: widget.addonModel != null ? 'Edit Addon' : 'Add Category',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextfield(
                title: 'Name',
                controller: model.nameController,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      title: 'Price',
                      controller: model.priceController,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomRadio(
                title: 'Status',
                options: [
                  activeString,
                  inActiveString,
                ],
                onSelectionChanged: (value) {
                  model.selectedStatus = value;
                },
                selectedStatus: widget.addonModel == null
                    ? activeString
                    : widget.addonModel?.isAvailable ?? true
                        ? activeString
                        : inActiveString,
              ),
            ],
          ),
          onSave: () {
            model.updateAddon();
          },
        );
      }),
    );
  }
}

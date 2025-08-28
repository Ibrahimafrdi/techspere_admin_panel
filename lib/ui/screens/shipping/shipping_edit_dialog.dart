import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/models/shipping.dart';
import 'package:kabir_admin_panel/ui/screens/shipping/shipping_screen_provider.dart';
import 'package:kabir_admin_panel/ui/widgets/common/add_or_edit_dialog.dart';
import 'package:kabir_admin_panel/ui/widgets/common/custom_radio.dart';
import 'package:kabir_admin_panel/ui/widgets/common/custom_textfield.dart';
import 'package:provider/provider.dart';

class ShippingEditDialog extends StatefulWidget {
  final Shipping? shippingModel;

  const ShippingEditDialog({super.key, this.shippingModel});

  @override
  State<ShippingEditDialog> createState() => _ShippingEditDialogState();
}

class _ShippingEditDialogState extends State<ShippingEditDialog> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShippingScreenProvider(),
      child: Consumer<ShippingScreenProvider>(builder: (context, model, child) {
        if (widget.shippingModel != null) {
          model.initShipping(widget.shippingModel!);
        }
        return AddOrEditDialog(
          title: widget.shippingModel != null
              ? 'Edit Shipping Area'
              : 'Add Shipping Area',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextfield(
                title: 'Area Name',
                controller: model.areaNameController,
              ),
              SizedBox(height: 10),
              CustomTextfield(
                title: 'Delivery Charge',
                controller: model.deliveryChargeController,
              ),
              SizedBox(height: 20),
              CustomRadio(
                title: 'Status',
                options: [
                  activeString,
                  inActiveString,
                ],
                onSelectionChanged: (value) {
                  model.selectedStatus = value;
                },
                selectedStatus: widget.shippingModel == null
                    ? activeString
                    : widget.shippingModel?.isAvailable ?? true
                        ? activeString
                        : inActiveString,
              )
            ],
          ),
          onSave: () {
            model.updateShipping();
          },
        );
      }),
    );
  }
}

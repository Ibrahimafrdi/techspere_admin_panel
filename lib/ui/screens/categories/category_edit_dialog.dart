import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/models/category.dart';
import 'package:kabir_admin_panel/ui/screens/categories/category_screen_provider.dart';
import 'package:kabir_admin_panel/ui/widgets/common/add_or_edit_dialog.dart';
import 'package:kabir_admin_panel/ui/widgets/common/custom_radio.dart';
import 'package:kabir_admin_panel/ui/widgets/common/custom_textfield.dart';
import 'package:provider/provider.dart';

class CategoryEditDialog extends StatefulWidget {
  final Category? categoryModel;

  const CategoryEditDialog({super.key, this.categoryModel});

  @override
  State<CategoryEditDialog> createState() => _CategoryEditDialogState();
}

class _CategoryEditDialogState extends State<CategoryEditDialog> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoryScreenProvider(),
      child: Consumer<CategoryScreenProvider>(builder: (context, model, child) {
        if (widget.categoryModel != null) {
          model.initCategory(widget.categoryModel!);
        }
        return AddOrEditDialog(
          title:
              widget.categoryModel != null ? 'Edit Category' : 'Add Category',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextfield(
                title: 'Name',
                controller: model.nameController,
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
                selectedStatus: widget.categoryModel == null
                    ? activeString
                    : widget.categoryModel?.isAvailable ?? true
                        ? activeString
                        : inActiveString,
              )
            ],
          ),
          onSave: () {
            model.updateCategory();
          },
        );
      }),
    );
  }
}

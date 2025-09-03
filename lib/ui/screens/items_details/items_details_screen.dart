
import 'package:kabir_admin_panel/ui/routing/app_router.dart';
import 'package:kabir_admin_panel/ui/screens/categories/category_edit_dialog.dart';
import 'package:web/web.dart' as web;
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/data_providers/categories_provider.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/core/models/item.dart';
import 'package:kabir_admin_panel/ui/screens/items/items_details_provider.dart';
import 'package:kabir_admin_panel/ui/widgets/common/custom_radio.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/header/add_button.dart';
import 'package:provider/provider.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Item? item;
  const ItemDetailsScreen({super.key, this.item});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FoodDetailsProvider(),
      child: Consumer2<FoodDetailsProvider, CategoriesProvider>(
          builder: (context, model, categoriesProvider, child) {
        if (widget.item != null) {
          model.initItem(widget.item!);
        }
        return InformationContent(model, categoriesProvider);
     
      }),
    );
  }

  Widget InformationContent(
      FoodDetailsProvider model, CategoriesProvider categoriesProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(7),
          bottomRight: Radius.circular(7),
        ),
        border: Border.all(
          color: primaryColor,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildEditColumn(
                      'Name', 'Wireless mouse', model.nameController),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: _buildCategorySelector(model, categoriesProvider),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: _buildEditColumn(
                      'Price', '1440', model.priceController),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomRadio(
                  title: 'Status',
                  options: [
                    activeString,
                    inActiveString,
                  ],
                  onSelectionChanged: (value) {
                    model.selectedStatus = value;
                  },
                  selectedStatus: widget.item == null
                      ? activeString
                      : widget.item?.isAvailable ?? true
                          ? activeString
                          : inActiveString,
                ),
                SizedBox(
                  width: 40,
                ),
                CustomRadio(
                  title: 'Featured',
                  options: [
                    'Yes',
                    'No',
                  ],
                  onSelectionChanged: (value) {
                    model.featured = value;
                  },
                  selectedStatus: widget.item == null
                      ? 'No'
                      : widget.item?.isFeatured ?? true
                          ? 'Yes'
                          : 'No',
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildEditColumn(
                    'Caution',
                    'Contains allergens',
                    model.cautionController,
                    isMultiLine: true,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: _buildEditColumn(
                    'Description',
                    'A detailed description of the item',
                    model.descController,
                    isMultiLine: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            DropTarget(
              onDragDone: (detail) {
                model.loadImage(detail.files, context);
              },
              onDragEntered: (detail) {
                model.toggleDragging(true);
              },
              onDragExited: (detail) {
                model.toggleDragging(false);
              },
              child: Container(
                child: model.dragging
                    ? Container(
                        height: 524,
                        width: double.infinity,
                        color: Colors.grey.shade400,
                        child: const Center(child: Text("Drop here")))
                    : ImagesContent(model),
              ),
            ),
            SizedBox(
              height: 20,
            ),
         
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                await model.addItem();
                appRouter.pop();
              },
              child: Container(
                width: 200,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(child: 'Save'.customText(color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditColumn(
      String label, String hint, TextEditingController controller,
      {bool isMultiLine = false, onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            controller: onChanged == null ? controller : null,
            minLines: isMultiLine ? 3 : 1,
            maxLines: isMultiLine ? 3 : 1,
            initialValue: onChanged != null ? controller.text : null,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector(
      FoodDetailsProvider model, CategoriesProvider categoriesProvider) {
    model.selectedCategory ??= categoriesProvider.categories.isNotEmpty
        ? categoriesProvider.categories.first.id!
        : '';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                    ),
                  ),
                  value: model.selectedCategory,
                  items: categoriesProvider.categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category.id,
                      child: Text(category.name!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    model.selectedCategory = value!;
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CategoryEditDialog();
                    },
                  );
                },
                icon: Icon(
                  Icons.add_box_outlined,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ImagesContent(FoodDetailsProvider model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 524,
          width: 524,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: model.imagePath != null
              ? HtmlElementView.fromTagName(
                  tagName: 'img',
                  onElementCreated: (image) {
                    image as web.HTMLImageElement;
                    image.style.width = '524px';
                    image.style.height = '524px';
                    // image.style.objectFit = 'cover';
                    image.src = model.imagePath!;
                    image.draggable = false;
                  },
                )
              : Image.asset(
                  'assets/images/techspere.png',
                  fit: BoxFit.cover,
                ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Square Image'.customText(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]!,
            ),
            SizedBox(height: 10),
            AddButton(
              text: 'Upload New Image',
              onTap: () {
                final input = FileUploadInputElement();
                input.accept = 'image/*';
                input.click();

                input.onChange.listen(
                  (e) async {
                    final files = input.files;
                    model.loadImage(files, context);
                  },
                );
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ],
    );
  }

}

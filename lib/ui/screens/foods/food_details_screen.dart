import 'package:kabir_admin_panel/core/constants/decorations.dart';
import 'package:kabir_admin_panel/core/data_providers/addons_provider.dart';
import 'package:kabir_admin_panel/core/models/action.dart';
import 'package:kabir_admin_panel/core/models/variation.dart';
import 'package:kabir_admin_panel/ui/routing/app_router.dart';
import 'package:kabir_admin_panel/ui/screens/categories/category_edit_dialog.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/data_grid.dart';
import 'package:web/web.dart' as web;
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import 'package:kabir_admin_panel/core/constants/string_constants.dart';
import 'package:kabir_admin_panel/core/data_providers/categories_provider.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/core/models/item.dart';
import 'package:kabir_admin_panel/ui/screens/foods/food_details_provider.dart';
import 'package:kabir_admin_panel/ui/widgets/common/custom_radio.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/header/add_button.dart';
import 'package:provider/provider.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Item? item;
  const FoodDetailsScreen({super.key, this.item});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
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
        // DefaultTabController(
        //   length: 4,
        //   child: Column(
        //     children: [
        //       _buildTabBar(),
        //       Expanded(
        //         child: TabBarView(
        //           physics: NeverScrollableScrollPhysics(),
        //           children: [
        //             _buildTabContent(
        //                 InformationContent(model, categoriesProvider)),
        //             _buildTabContent(
        //               DropTarget(
        //                 onDragDone: (detail) {
        //                   model.toggleDragging(false);
        //                   model.loadImage(detail.files);
        //                 },
        //                 onDragEntered: (detail) {
        //                   model.toggleDragging(true);
        //                 },
        //                 onDragExited: (detail) {
        //                   model.toggleDragging(false);
        //                 },
        //                 child: Container(
        //                   child: model.dragging
        //                       ? const Center(child: Text("Drop here"))
        //                       : ImagesContent(model),
        //                 ),
        //               ),
        //             ),
        //             _buildTabContent(VariationsContent(model)),
        //             _buildTabContent(AddonsContent(model)),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      }),
    );
  }

  // Widget _buildTabBar() {
  //   return TabBar(
  //     labelColor: primaryColor,
  //     splashFactory: NoSplash.splashFactory,
  //     dividerColor: primaryColor,
  //     indicator: _buildTabIndicator(),
  //     indicatorSize: TabBarIndicatorSize.tab,
  //     tabs: [
  //       _buildTab(Icons.info_outlined, 'Information'),
  //       _buildTab(Icons.image_outlined, 'Images'),
  //       _buildTab(Icons.format_list_bulleted_outlined, 'Variations'),
  //       _buildTab(Icons.add_circle_outline_outlined, 'Addons'),
  //     ],
  //   );
  // }

  // BoxDecoration _buildTabIndicator() {
  //   return BoxDecoration(
  //     borderRadius: BorderRadius.only(
  //       topLeft: Radius.circular(7),
  //       topRight: Radius.circular(7),
  //     ),
  //     color: Colors.white,
  //     border: Border(
  //       top: BorderSide(color: primaryColor),
  //       left: BorderSide(color: primaryColor),
  //       right: BorderSide(color: primaryColor),
  //     ),
  //   );
  // }

  // Widget _buildTab(IconData icon, String label) {
  //   return Tab(
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Icon(icon),
  //         SizedBox(width: 10),
  //         Text(label),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildTabContent(Widget content) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(7),
          bottomRight: Radius.circular(7),
        ),
        border: Border(
          bottom: BorderSide(color: primaryColor),
          left: BorderSide(color: primaryColor),
          right: BorderSide(color: primaryColor),
        ),
      ),
      child: content,
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
                      'Name', 'Chicken Burger', model.nameController),
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
                      'Price', '\$9.99', model.priceController),
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
                    'A delicious chicken burger with fresh vegetables and our special sauce.',
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: VariationsContent(model)),
                SizedBox(
                  width: 20,
                ),
                Expanded(child: AddonsContent(model)),
              ],
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
                  'assets/images/item.png',
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

  Widget VariationsContent(FoodDetailsProvider model) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.variations.length,
                  itemBuilder: (context, variationIndex) {
                    final variation = model.variations[variationIndex];
                    return Container(
                      padding: EdgeInsets.all(25).copyWith(top: 0),
                      margin: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F7FC),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: variation.isPrimary ?? false,
                                  onChanged: (value) {
                                    variation.isPrimary = value;
                                    if (value ?? false) {
                                      variation.isRequired = value;
                                    }
                                    model.updateVariation(
                                        variation, variationIndex);
                                  },
                                ),
                                'Primary'.customText(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: variation.isRequired ?? false,
                                  onChanged: (variation.isPrimary ?? false)
                                      ? null
                                      : (value) {
                                          variation.isRequired = value;

                                          model.updateVariation(
                                              variation, variationIndex);
                                        },
                                ),
                                'Required'.customText(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            CustomRadio(
                              selectedStatus:
                                  (variation.isSingleSelection ?? true)
                                      ? 'Single Selection'
                                      : 'Multiple Selection',
                              options: [
                                'Single Selection',
                                'Multiple Selection'
                              ],
                              onSelectionChanged: (value) {
                                variation.isSingleSelection =
                                    value == 'Single Selection' ? true : false;
                                model.updateVariation(
                                    variation, variationIndex);
                              },
                            ),
                            IconButton(
                              color: Colors.red,
                              onPressed: () {
                                model.removeVariation(variationIndex);
                              },
                              icon: Icon(
                                Icons.delete,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            _buildEditColumn(
                              'Name',
                              'size',
                              TextEditingController(text: variation.name),
                              onChanged: (value) {
                                variation.name = value;
                                model.updateVariation(
                                    variation, variationIndex);
                              },
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: variation.options?.length,
                                    itemBuilder: (context, optionIndex) {
                                      final option =
                                          variation.options?[optionIndex];
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: _buildEditColumn(
                                              'Option name',
                                              'Regular',
                                              TextEditingController(
                                                  text: option?.name),
                                              onChanged: (value) {
                                                option?.name = value;
                                                variation
                                                        .options?[optionIndex] =
                                                    option!;
                                                model.updateVariation(
                                                    variation, variationIndex);
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: _buildEditColumn(
                                              'price',
                                              '20',
                                              TextEditingController(
                                                  text: option?.price
                                                      ?.toString()),
                                              onChanged: (value) {
                                                option?.price =
                                                    double.parse(value);
                                                variation
                                                        .options?[optionIndex] =
                                                    option!;
                                                model.updateVariation(
                                                    variation, variationIndex);
                                              },
                                            ),
                                          ),
                                          IconButton(
                                            color: Colors.red,
                                            onPressed: () {
                                              variation.options
                                                  ?.removeAt(optionIndex);
                                              model.updateVariation(
                                                  variation, variationIndex);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  AddButton(
                                    text: 'Add Option',
                                    onTap: () {
                                      // Assuming there's a method to add a variation in the FoodDetailsProvider
                                      variation.options?.add(VariationOption());
                                      model.updateVariation(
                                          variation, variationIndex);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: AddButton(
                  text: 'Add Variation',
                  onTap: () {
                    // Assuming there's a method to add a variation in the FoodDetailsProvider
                    model.addItemVariation();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget AddonsContent(FoodDetailsProvider model) {
    return Consumer<AddonsProvider>(builder: (context, addonsProvider, _) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: primaryDecoration.copyWith(color: Colors.white),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Selected Addons'.customText(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          AddButton(
                            text: 'Select Addons',
                            onTap: () {
                              // Show addon selection dialog
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Select Addons'),
                                  content: Container(
                                    width: 500,
                                    height: 400,
                                    child: ListView.builder(
                                      itemCount: addonsProvider.addons.length,
                                      itemBuilder: (context, index) {
                                        final addon =
                                            addonsProvider.addons[index];
                                        return CheckboxListTile(
                                          title: Text(addon.name ?? ''),
                                          value: model.selectedAddons
                                              .contains(addon),
                                          onChanged: (selected) {
                                            if (selected!) {
                                              model.addAddon(addon);
                                            } else {
                                              model.removeAddon(addon);
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Done'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          AddButton(
                            text: 'Add New Addon',
                            onTap: () {
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return AddonEditDialog();
                              //   },
                              // );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      DataGrid(
                        columnNames: ['name', 'price', 'action'],
                        records: model.selectedAddons
                            .map((addon) => [
                                  addon.name,
                                  addon.price,
                                  [
                                    ActionModel(
                                      text: 'delete',
                                      onTap: () => model.removeAddon(addon),
                                    ),
                                  ],
                                ])
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}

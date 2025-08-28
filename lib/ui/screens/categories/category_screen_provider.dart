import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/models/category.dart';
import 'package:kabir_admin_panel/core/services/database_services.dart';
import 'package:kabir_admin_panel/core/view_models/base_view_model.dart';

class CategoryScreenProvider extends BaseViewModal {
  DatabaseServices _databaseServices = DatabaseServices();

  String selectedStatus = 'Active';
  TextEditingController nameController = TextEditingController();
  Category category = Category();

  initCategory(Category category) {
    nameController.text = category.name ?? '';
    selectedStatus = (category.isAvailable ?? true) ? 'Active' : 'Inactive';
    this.category = category;
    notifyListeners();
  }

  updateCategory() {
    category.name = nameController.text;
    category.isAvailable = selectedStatus == 'Active' ? true : false;

    _databaseServices.addCategory(category);
  }
}

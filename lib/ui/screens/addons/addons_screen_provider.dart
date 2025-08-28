import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/models/addon.dart';
import 'package:kabir_admin_panel/core/services/database_services.dart';
import 'package:kabir_admin_panel/core/view_models/base_view_model.dart';

class AddonsScreenProvider extends BaseViewModal {
  DatabaseServices _databaseServices = DatabaseServices();

  String selectedStatus = 'Active';
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  Addon addon = Addon();

  initAddon(Addon addon) {
    nameController.text = addon.name ?? '';
    priceController.text = addon.price?.toString() ?? '';
    selectedStatus = (addon.isAvailable ?? true) ? 'Active' : 'Inactive';
    this.addon = addon;
    notifyListeners();
  }

  updateAddon() {
    addon.name = nameController.text;
    addon.price = double.parse(priceController.text);
    addon.isAvailable = selectedStatus == 'Active' ? true : false;

    _databaseServices.addAddon(addon);
  }
}

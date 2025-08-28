import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/models/shipping.dart';
import 'package:kabir_admin_panel/core/services/database_services.dart';
import 'package:kabir_admin_panel/core/view_models/base_view_model.dart';

class ShippingScreenProvider extends BaseViewModal {
  DatabaseServices _databaseServices = DatabaseServices();

  String selectedStatus = 'Active';
  TextEditingController areaNameController = TextEditingController();
  TextEditingController deliveryChargeController = TextEditingController();
  Shipping shipping = Shipping();

  initShipping(Shipping shipping) {
    areaNameController.text = shipping.areaName ?? '';
    deliveryChargeController.text = shipping.deliveryCharge?.toString() ?? '';
    selectedStatus = (shipping.isAvailable ?? true) ? 'Active' : 'Inactive';
    this.shipping = shipping;
    notifyListeners();
  }

  updateShipping() {
    shipping.areaName = areaNameController.text;
    shipping.deliveryCharge = double.tryParse(deliveryChargeController.text);
    shipping.isAvailable = selectedStatus == 'Active' ? true : false;

    _databaseServices.addShipping(shipping);
  }
}

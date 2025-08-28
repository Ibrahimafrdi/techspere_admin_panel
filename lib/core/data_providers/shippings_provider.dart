import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/models/shipping.dart';
import 'package:kabir_admin_panel/core/services/database_services.dart';

class ShippingsProvider extends ChangeNotifier {
  final DatabaseServices _databaseServices = DatabaseServices();
  List<Shipping> _shippings = [];

  List<Shipping> get shippings => _shippings;

  ShippingsProvider() {
    _initShippings();
  }

  void _initShippings() {
    _databaseServices.getShippingsStream().listen((shippings) {
      _shippings = shippings;
      notifyListeners();
    });
  }

  Future<void> deleteShipping(String id) async {
    await _databaseServices.deleteShipping(id);
    notifyListeners();
  }
}

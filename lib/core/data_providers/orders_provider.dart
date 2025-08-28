import 'package:kabir_admin_panel/core/models/order.dart';
import 'package:kabir_admin_panel/core/services/database_services.dart';
import 'package:kabir_admin_panel/core/view_models/base_view_model.dart';

class OrdersProvider extends BaseViewModal {
  final DatabaseServices _databaseServices = DatabaseServices();

  // items
  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

  OrdersProvider() {
    listenToOrders();
  }

  listenToOrders() {
    Stream<List<OrderModel>> ordersStream = _databaseServices.getOrdersStream();
    ordersStream.listen((orders) {
      _orders = orders;
      notifyListeners();
    });
  }
}

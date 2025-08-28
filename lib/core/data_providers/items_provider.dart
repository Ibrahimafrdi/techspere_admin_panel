import 'package:kabir_admin_panel/core/models/item.dart';
import 'package:kabir_admin_panel/core/services/database_services.dart';
import 'package:kabir_admin_panel/core/view_models/base_view_model.dart';

class ItemsProvider extends BaseViewModal {
  final DatabaseServices _databaseServices = DatabaseServices();

  // items
  List<Item> _items = [];
  List<Item> get items => _items;

  ItemsProvider() {
    listenToItems();
  }

  listenToItems() {
    Stream<List<Item>> itemsStream = _databaseServices.getItemsStream();
    itemsStream.listen((items) {
      _items = items;
      notifyListeners();
    });
  }

  deleteItem(String id) async {
    await _databaseServices.deleteItem(id);
    listenToItems();
  }
}

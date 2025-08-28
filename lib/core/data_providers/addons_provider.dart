import 'package:kabir_admin_panel/core/models/addon.dart';
import 'package:kabir_admin_panel/core/services/database_services.dart';
import 'package:kabir_admin_panel/core/view_models/base_view_model.dart';

class AddonsProvider extends BaseViewModal {
  final DatabaseServices _databaseServices = DatabaseServices();

  // items
  List<Addon> _addons = [];
  List<Addon> get addons => _addons;

  AddonsProvider() {
    listenToAddons();
  }

  listenToAddons() {
    Stream<List<Addon>> addonsStream = _databaseServices.getAddonsStream();
    addonsStream.listen((addons) {
      _addons = addons;
      notifyListeners();
    });
  }

  deleteAddon(String id) async {
    await _databaseServices.deleteAddon(id);
    listenToAddons();
  }
}

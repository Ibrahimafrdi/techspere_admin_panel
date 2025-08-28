import 'package:kabir_admin_panel/core/models/category.dart';
import 'package:kabir_admin_panel/core/services/database_services.dart';
import 'package:kabir_admin_panel/core/view_models/base_view_model.dart';

class CategoriesProvider extends BaseViewModal {
  final DatabaseServices _databaseServices = DatabaseServices();

  // categories
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  CategoriesProvider() {
    listenToCategories();
  }

  listenToCategories() {
    Stream<List<Category>> categoriesStream =
        _databaseServices.getCategoriesStream();
    categoriesStream.listen((categories) {
      _categories = categories;
      notifyListeners();
    });
  }

  deleteCategory(String id) async {
    await _databaseServices.deleteCategory(id);
    listenToCategories();
  }
}

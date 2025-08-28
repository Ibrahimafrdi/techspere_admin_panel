import 'package:kabir_admin_panel/core/models/rider.dart';
import 'package:kabir_admin_panel/core/services/database_services.dart';
import 'package:kabir_admin_panel/core/view_models/base_view_model.dart';

class RidersProvider extends BaseViewModal {
  final DatabaseServices _databaseServices = DatabaseServices();

  // riders
  List<Rider> _riders = [];
  List<Rider> get riders => _riders;

  RidersProvider() {
    listenToRiders();
  }

  listenToRiders() {
    Stream<List<Rider>> ridersStream = _databaseServices.getRidersStream();
    ridersStream.listen((riders) {
      _riders = riders;
      notifyListeners();
    });
  }

  deleteRider(String id) async {
    await _databaseServices.deleteRider(id);
  }

  addRider(Rider rider) async {
    await _databaseServices.addRider(rider);
  }

  updateRider(Rider rider) async {
    await _databaseServices.updateRider(rider);
  }
}

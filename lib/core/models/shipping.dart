import 'package:uuid/uuid.dart';

class Shipping {
  String? id;
  String? areaName;
  double? deliveryCharge;
  bool? isAvailable;

  Shipping({
    this.id,
    this.areaName,
    this.deliveryCharge,
    this.isAvailable = true,
  }) {
    id = id ?? const Uuid().v4();
  }

  Map<String, dynamic> toJson() {
    return {
      'areaName': areaName,
      'deliveryCharge': deliveryCharge,
      'isAvailable': isAvailable,
    };
  }

  factory Shipping.fromJson(Map<String, dynamic> json, String id) {
    return Shipping(
      id: id,
      areaName: json['areaName'],
      deliveryCharge: json['deliveryCharge']?.toDouble(),
      isAvailable: json['isAvailable'],
    );
  }
}

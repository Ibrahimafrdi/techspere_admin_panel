import 'package:kabir_admin_panel/core/models/address.dart';
import 'package:kabir_admin_panel/core/models/order_item.dart';

class OrderModel {
  String? id;
  String? userId;
  String? riderId;
  String? userName;
  String? userPhone;
  List<OrderItem>? items;
  double? subtotal;
  double? discount;
  double? deliveryCharges;
  double? total;
  String? status;
  DateTime? createdAt;
  Address? deliveryAddress;

  OrderModel({
    this.id,
    this.userId,
    this.riderId,
    this.userName,
    this.userPhone,
    this.items,
    this.subtotal,
    this.discount,
    this.deliveryCharges,
    this.total,
    this.status,
    this.createdAt,
    this.deliveryAddress,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json, id) {
    return OrderModel(
      id: id,
      userId: json['userId'],
      riderId: json['riderId'],
      userName: json['userName'],
      userPhone: json['userPhone'],
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtotal: json['subtotal']?.toDouble(),
      discount: json['discount']?.toDouble(),
      deliveryCharges: json['deliveryCharges']?.toDouble(),
      total: json['total']?.toDouble(),
      status: json['status'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      deliveryAddress: json['deliveryAddress'] != null
          ? Address.fromJson(json['deliveryAddress'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'riderId': riderId,
      'userName': userName,
      'userPhone': userPhone,
      'items': items?.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'discount': discount,
      'deliveryCharges': deliveryCharges,
      'total': total,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'deliveryAddress': deliveryAddress?.toJson(),
    };
  }

  void calculateTotals() {
    subtotal =
        items?.fold<double>(0, (sum, item) => sum + (item.totalPrice ?? 0)) ??
            0;
    total = (subtotal ?? 0) - (discount ?? 0) + (deliveryCharges ?? 0);
  }
}

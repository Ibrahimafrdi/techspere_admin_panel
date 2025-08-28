class Extra {
  String? id;
  String? name;
  double? price;
  bool? isAvailable;

  Extra({
    this.id,
    this.name,
    this.price,
    this.isAvailable,
  });

  factory Extra.fromJson(Map<String, dynamic> json) {
    return Extra(
      id: json['id'],
      name: json['name'],
      price: json['price']?.toDouble(),
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'isAvailable': isAvailable ?? true,
    };
  }
}

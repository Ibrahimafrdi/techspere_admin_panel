class Rider {
  String? id;
  String? name;
  String? email;
  String? phone;
  bool? isActive;

  Rider({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'isActive': isActive,
    };
  }

  factory Rider.fromMap(Map<String, dynamic> map, id) {
    return Rider(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      isActive: map['isActive'] ?? true,
    );
  }
}

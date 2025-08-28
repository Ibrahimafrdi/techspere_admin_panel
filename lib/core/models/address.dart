import 'package:google_maps_flutter/google_maps_flutter.dart';

class Address {
  String? name;
  LatLng? location;
  String? address;

  Address({this.name, this.location, this.address});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location != null
          ? {'latitude': location!.latitude, 'longitude': location!.longitude}
          : null,
      'address': address,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      name: json['name'],
      location: json['location'] != null
          ? LatLng(json['location']['latitude'], json['location']['longitude'])
          : null,
      address: json['address'],
    );
  }
}

//import 'package:flutter/cupertino.dart';
import 'dart:convert';

class Cliente {
  final int? id;
  final String name;
  final String email;
  final String zipCode;
  final String state;
  final String city;
  final String district;
  final String street;
  final String streetNumber;

  //Client(this.firstName, this.lastName, this.zipCode);
  Cliente(this.id, this.name, this.email, this.zipCode, this.state, this.city,
      this.district, this.street, this.streetNumber);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'zipCode': zipCode,
      'state': state,
      'city': city,
      'district': district,
      'street': street,
      'streetNumber': streetNumber,
    };
  }

  Cliente.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        zipCode = json['zipCode'],
        state = json['state'],
        city = json['city'],
        district = json['district'],
        street = json['street'],
        streetNumber = json['streetNumber'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'zipCode': zipCode,
        'state': state,
        'city': city,
        'district': district,
        'street': street,
        'streetNumber': streetNumber
      };
}

List<Cliente> clientFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Cliente>.from(data.map((item) => Cliente.fromJson(item)));
}

String clientToJson(Cliente data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

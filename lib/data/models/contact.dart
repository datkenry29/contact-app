import 'package:flutter/cupertino.dart';

class Contact {
  int? id;
  String imageUrl;
  String firstName;
  String lastName;
  String phone;
  String typePhone;
  String email;
  String typeEmail;

  Contact({
    this.id,
    required this.imageUrl,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.typePhone,
    required this.email,
    required this.typeEmail
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'image_url': imageUrl,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'type_phone': typePhone,
      'email': email,
      'type_email': typeEmail,
    };
    return map;
  }

  Contact.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        imageUrl = map['image_url'],
        firstName = map['first_name'],
        lastName = map['last_name'],
        phone = map['phone'],
        typePhone = map['type_phone'],
        email = map['email'],
        typeEmail = map['type_email'];
}
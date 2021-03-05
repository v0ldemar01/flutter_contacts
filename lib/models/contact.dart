import 'package:flutter/material.dart';

class Contact {
  int id;
  String name;
  String email;
  String phone;

  Contact({ this.id, @required this.name, @required this.email, @required this.phone });

  factory Contact.fromJson(Map<String, dynamic> responseData) {
    return Contact(        
      id: responseData['id'] as int,
      name: responseData['name'] as String,
      email: responseData['email'] as String,
      phone: responseData['phone'] as String       
    );
  }
}

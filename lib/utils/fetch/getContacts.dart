import 'dart:convert';
import 'package:flutter_contacts/models/contact.dart';
import 'package:http/http.dart' as http;

getContacts() async{
  final response = await http.get('https://jsonkeeper.com/b/SH0W');
  if (response.statusCode == 200){
    var allData = json.decode(response.body);    
    var dataList = List<Contact>();
    allData.forEach((value) {      
      var contactElement = Contact.fromJson(value);
      dataList.add(contactElement);
    });
    return dataList;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return List();
  }
}
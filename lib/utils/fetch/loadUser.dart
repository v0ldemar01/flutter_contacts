import 'dart:convert';
import 'package:flutter/services.dart';

readJson() async {
  final String response = await rootBundle.loadString('assets/user/data.json');
  return await json.decode(response);    
}
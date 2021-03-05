import 'package:flutter/material.dart';
import 'package:flutter_contacts/pages/contact_list_page.dart' show ContactList;
import 'package:flutter_contacts/pages/sign_in_page.dart' show SignIn;
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(        
        visualDensity: VisualDensity.adaptivePlatformDensity,        
      ),
      home: SignIn(),      
      routes: {
        '/contacts': (context) => ContactList(),
        '/signIn': (context) => SignIn()        
      },
    );
  }
}


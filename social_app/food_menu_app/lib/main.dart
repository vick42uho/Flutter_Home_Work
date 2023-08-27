import 'package:flutter/material.dart';
import 'package:food_menu_app/menu.dart';
import './menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Food Menu"),
        ),
        body: Menu(),
      ),
    );
  }
}

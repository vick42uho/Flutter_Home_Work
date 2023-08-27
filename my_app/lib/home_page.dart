import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
        tag: 'hero',
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircleAvatar(
              radius: 72.0,
              backgroundColor: Colors.lightBlueAccent,
            )));

    final welcome = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Welcome Alucard',
          style: TextStyle(fontSize: 28.0, color: Colors.white),
        ));

    final lores = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Welcome to My Application of Flutter',
          style: TextStyle(fontSize: 28.0, color: Colors.white),
        ));

    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(28.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.lightBlueAccent])),
            child: Column(
              children: <Widget>[logo, welcome, lores],
            )));
  }
}

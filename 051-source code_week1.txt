import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: Text('Flutter Home Work FistWeek'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
              },
            )
          ],
        ),

        body: Container(alignment: Alignment.center,
          color: Colors.white70,
          child: Column(
            children: <Widget>[
              Image(image: AssetImage('images/Arsenal_FC.png'),),
              Text('Arsenal The Gunners',style: TextStyle(color: Colors.black,fontSize: 38),),
              Text('5933470051',style: TextStyle(color: Colors.black,fontSize: 36),),
              Text('Thaweep Poraha',style: TextStyle(color: Colors.black,fontSize: 36),),
            ],
          ),),

        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Text('051'),
              Divider(),
              Text('Thaweep'),
              Divider(),
              Text('Poraha')
            ],

          ),
        ),
      ),
    );
  }
}
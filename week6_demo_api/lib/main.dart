import 'dart:convert';

import 'package:flutter/material.dart';

import 'model/emp.dart';
import 'package:http/http.dart' as http;

Future<List<Emp>> getEmp() async {
  String url = 'http://kungtee.com/employee.php';
  // http.Response response = await http.get(url);
  http.Response response = await http.get(url);
  // Try to convert json to dart object
  List<Emp> allEmp = new List();
  List<dynamic> Empployee = json.decode(response.body);

  for (var empJson in Empployee) {
    var emp = Emp.fromJson(empJson);
    // print(emp.first_name);
    allEmp.add(emp);
  }
  // print('count ${allEmp.length}');
  return allEmp;
}




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(

          child: FutureBuilder<List<Emp>>(
            future: getEmp(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return new  ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    // return EmpObject(item: snapshot.data[index]);
                    return Container(
                        padding: EdgeInsets.all(2),
                        height: 140,
                        child: Card(
                          elevation: 5,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                Image.network(
                                  "${snapshot.data[index].imgUrl}",
                                  width: 100,
                                ),
                                Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[

                                            Text("id:${snapshot.data[index].id}"),
                                            Text("first_name:${snapshot.data[index].first_name}"),
                                            Text("last_name:${snapshot.data[index].last_name}"),
                                            Text("email_address:${snapshot.data[index].email_address}"),

                                          ],
                                        )))
                              ]),
                        ));
                  },
                );

              }
              else if(snapshot.hasError){
                return new Text("${snapshot.error}");
              }
              else{
                //return loading action
                return new Container(alignment: AlignmentDirectional.center,
                  child: new CircularProgressIndicator(),
                );
              }

            },
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
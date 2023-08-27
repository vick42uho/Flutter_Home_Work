import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String random_number(){
  var rgn=new Random();
  String num=rgn.nextInt(9).toString();
  return num;
}

class _MyHomePageState extends State<MyHomePage> {
  final txt1=TextEditingController();
  int _counter = 0;
  String _answer=random_number();
  String _result="";
  void _guess_number(){
    setState(() {
      if(_answer==txt1.text){
        _result="ถูกต้อง";
      }
      else{
        //_result="คำตอบผิด ที่ถูกคือ :"+_answer;
        _result="คำตอบผิด ที่ถูกคือ : $_answer";
      }

    });
  }

  void _new_game(){
    setState(() {
      _result = 'เดาตัวเลข';
      _answer = random_number();
      txt1.text = '';
    });
  }

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: txt1,
              keyboardType: TextInputType.number,
            ),
            Text(
              // "ans : $_result"
                _result
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.red,
                  onPressed: (){
                    //print(random_number());
                    // print(txt1.text);
                    _guess_number();
                  },
                  child:Text('ส่งคำตอบ'),
                ),
                Padding(padding: EdgeInsets.all(5)),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: (){
                    _new_game();
                  },
                  child:Text('เริ่มใหม่'),
                ),
              ],
            ),


          ],
        ),
      ),

    );
  }
}
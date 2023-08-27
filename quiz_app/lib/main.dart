import 'package:flutter/material.dart';

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
            title: Text("Quiz App"),
            backgroundColor: Colors.teal,
          ),
          body: QuizApp()),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {

  // String name = "john";

  Map<int, Map<String, dynamic>> quizLists = {
    1 : {"q" : "แมวเป็นสัตว์เลี้ยงลูกด้วยนม มี 4 ขา", "a" : true },
    2 : {"q" : "ดาวเคราะห์ที่อยู่ดวงอาทิตย์ที่สุดคือดาวเสาร์", "a" : false },
    3 : {"q" : "ยูนิคอน เป็นสัตว์ท้องถิ่นของ Scotland", "a" : true },
  };

  int score = 0;
  int quizNumber = 1;


  void submit(bool answer) {

    if ( quizLists[quizNumber]["a"] == answer) {
      score = score+1;
    }

    if ( quizNumber == quizLists.length) {

      showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
        return AlertDialog(
//          shape: ,
          title: Text("Congratulations!"),
          content: Text("You score is $score out of ${quizLists.length}"),
          actions: [
            FlatButton(
              textColor: Colors.teal,
              child: Text("RESTART QUIZ"),
              onPressed: () {
                setState(() {
                  quizNumber = 1;
                  score = 0;
                });
                Navigator.of(context).pop();

              },
            )
          ],
        );
        }
      );
    } else {
      setState(() {
        quizNumber = quizNumber+1;
      });
    }


  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "${quizLists[quizNumber]["q"]}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        Container(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  color: Colors.green,
                  child: IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      submit(true);
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  height: 60,
                  color: Colors.red,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      submit(false);
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    ));
  }
}

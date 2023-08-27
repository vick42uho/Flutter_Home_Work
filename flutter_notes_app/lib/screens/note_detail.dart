import 'package:flutter/material.dart';
import 'package:flutter_notes_app/models/note.dart';
import 'package:flutter_notes_app/utils/database_helper.dart';
import 'package:intl/intl.dart';


class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  static var _priorites = ['High','Low'];
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NoteDetailState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = note.title;
    descriptionController.text = note.description;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScreen();
            }
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // First element องค์ประกอบแรก
              ListTile(
                title: DropdownButton(
                  items: _priorites.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem)
                    );
                  }).toList(),
                  style: textStyle,
                  value: getPriorityAsString(note.priority),
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      debugPrint('User selected $valueSelectedByUser');
                      updatePriorityAsInt(valueSelectedByUser);
                    });
                  },
                ),
              ),

              // Second Element องค์ประกอบที่สอง
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom:  15.0),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (value) {
                    debugPrint('มีการเปลี่ยนแปลงบางอย่างในฟิลด์ข้อความชื่อเรื่อง');
                    updateTitle();
                  },
                  decoration: InputDecoration(
                    labelText: 'หัวข้อ',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                )
              ),

              // Third Element องค์ประกอบที่สาม
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  minLines: 2,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  controller: descriptionController,
                  style: textStyle,
                  onChanged: (value) {
                    debugPrint('มีการเปลี่ยนแปลงในฟิลด์ข้อความคำอธิบาย');
                    updateDescription();
                  },

                  decoration: InputDecoration(
                    labelText: 'โน้ต',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0)
                    )
                  ),
                )
              ),



              // Fourth Element องค์ประกอบที่สี่
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'บันทึก',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint('คลิกปุ่มบันทึกแล้ว');
                            _save();
                          });
                        },
                      ),
                    ),
                    Container(width: 5.0,),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'ลบ',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: (){
                          setState(() {
                            debugPrint('คลิกปุ่มลบ');
                            _delete();
                          });
                        },
                      ),
                    )
                  ],
                )
              )
            ],
          )
        )
      )
    );
  }


  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  String getPriorityAsString(int value) {
    String priority;

    switch (value) {
      case 1:
        priority = _priorites[0]; // High
        break;
      case 2:
        priority = _priorites[1]; // Low
        break;
    }

    return priority;
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();

    note.date = DateFormat.yMMMEd().format(DateTime.now());
    int result;

    if (note.id != null) {
      result = await helper.updateNote(note);
    } else {
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      _showAlertDialog('สถานะ', 'บันทึกสำเร็จ');
    } else {
      _showAlertDialog('สถานะ', 'ปัญหาในการบันทึก');
    }
  }

  void _delete() async {
    moveToLastScreen();

    if (note.id == null) {
      _showAlertDialog('สถานะ', 'ไม่มีการลบโน้ต');
      return;
    }

    int result = await helper.deleteNote(note.id);

    if (result != 0) {
      _showAlertDialog('สถานะ', 'ลบสำเร็จ');
    } else {
      _showAlertDialog('สถานะ', 'เกิดข้อผิดพลาดขณะลบบันทึก');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message)
    );

    showDialog(
      context: context,
      builder: (_) => alertDialog
    );
  }
}
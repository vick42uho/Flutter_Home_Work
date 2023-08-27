import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'DialogBox.dart';


class LoginRegisterPage extends StatefulWidget
{
  LoginRegisterPage
  ({
    this.auth,
    this.onSignedIn,
  });
  final AuthImplementaion auth;
  final VoidCallback onSignedIn;




  State<StatefulWidget> createState()
  {
    return _LoginRegisterState();
  }


}

enum FormType
{
  login,
  register
}



class _LoginRegisterState extends State<LoginRegisterPage>
{
  DialogBox dialogBox = new DialogBox();

  final formkey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";


  //methods
  bool validateAndSave()
  {
    final form = formkey.currentState;

    if(form.validate())
    {
      form.save();
      return true;
    }
    else
    {
      return false;
    }

  }

  void validateAndSubmit() async
  {
    if(validateAndSave())
    {
      try
      {
        if(_formType == FormType.login)
        {
          String userId = await widget.auth.SignIn(_email, _password);
          dialogBox.information(context, "ขอแสดงความยินดี", "คุณเข้าสู่ระบบเรียบร้อยแล้ว");
          print("login userId = " + userId);
        }
        else
        {
          String userId = await widget.auth.SignUp(_email, _password);
          dialogBox.information(context, "ขอแสดงความยินดี", "บัญชีของคุณสร้างเสร็จเรียบร้อยแล้ว");
          print("Register userId = " + userId);
        }

        widget.onSignedIn();
      }
      catch(e)
      {
        dialogBox.information(context, "Error", e.toString());
        print("Error = " + e.toString());
    }
  }
}

  void moveToRegister()
  {
    formkey.currentState.reset();


    setState(() 
    {
            _formType = FormType.register; 
    });
  }


void moveToLogin()
  {
    formkey.currentState.reset();


    setState(() 
    {
            _formType = FormType.login; 
    });
  }





  //Desing
  @override
    Widget build(BuildContext context)
    {
      return new Scaffold
      (
        appBar: new AppBar
        (
        title: new Text('Flutter Blog App'),
      ),


      body: new Container
      (
        margin: EdgeInsets.all(15.0),

        child: new Form
        (
          key: formkey,



          child: new Column
          (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButtons(),

          ),
        ),
      ),

      );
    }

    List<Widget> createInputs()
    {
      return
      [
        SizedBox(height: 10.0),
        logo(),
        SizedBox(height: 20.0),

        new TextFormField
        (
          decoration: new InputDecoration(labelText: 'Email'),


          validator: (value)
          {
            return value.isEmpty ? 'ต้องระบุอีเมล' : null;

          },

          onSaved: (value)
          {
            return _email = value;
          },


        ),
        SizedBox(height: 10.0),


        new TextFormField
        (
          decoration: new InputDecoration(labelText: 'password'),
          obscureText: true,

          validator: (value)
          {
            return value.isEmpty ? 'ต้องระบุรหัสผ่าน' : null;

          },

          onSaved: (value)
          {
            return _password = value;
          },
        ),
        SizedBox(height: 20.0),

      ];
    }


    Widget logo()
    {
      return new Hero
      (
        tag: 'hero',


        child: new CircleAvatar
        (
          backgroundColor: Colors.transparent,
          radius: 110.0,
          child: Image.asset('images/app_logo.png'),
        ),
      );
    }

     List<Widget> createButtons()
    {
          if(_formType == FormType.login)
          {
             return
            [
              
              new RaisedButton
              (
                child: new Text('เข้าสู่ระบบ', style: new TextStyle(fontSize: 20.0)),
                textColor: Colors.white,
                color: Colors.green,

                onPressed: validateAndSubmit,
              ),

              new FlatButton
              (
                child: new Text('ยังไม่มีบัญชี? สร้างบัญชี?',style: new TextStyle(fontSize: 20.0)),
                textColor: Colors.blue,
                


                onPressed: moveToRegister,
              ),

            ];
          }

          else
          {
             return
              [
                
                new RaisedButton
                (
                  child: new Text('สร้างบัญชี', style: new TextStyle(fontSize: 20.0)),
                  textColor: Colors.white,
                  color: Colors.pink,

                  onPressed: validateAndSubmit,
                ),

                new FlatButton
                (
                  child: new Text('มีบัญชีอยู่แล้ว? เข้าสู่ระบบ',style: new TextStyle(fontSize: 20.0)),
                  textColor: Colors.red,
                  


                  onPressed: moveToLogin,
                ),

              ];
          }
    }
}
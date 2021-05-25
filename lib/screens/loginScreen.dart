import 'package:flutter/material.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:untitled1/utis/dbhelper.dart';

import 'islemMenusu.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State {
  var user = Users();
  var formKey = GlobalKey<FormState>();
  var userList = List<Users>();

  DatabaseHelper dbhelper = DatabaseHelper();
  @override
  void initState() {
    fetch();
    super.initState();
  }

  Future<void> fetch() async {
    var temp = await getListOfUsers();
    setState(() {
      userList = temp;
    });
  }

  Future<List<Users>> getListOfUsers() async {
    var userList = await dbhelper.getUsersList();
    var usersL = userList;
    if (usersL != null) {
      return usersL;
    }
  }

  String validateUserName(String value) {
    if (!(userList.any((e) => e.userName == value))) {
      print(userList.length.toString() + "şierlhmişerlhmeşrhlmerşhlmş");
      return "Kullanıcı Adınız Yanlış, Lütfen Tekrar Deneyin";
    }
  }

  String validatePassword(String value) {
    if (!(userList.any((e) => e.userPassword == value))) {
      return "Şifreniz Yanlış, Lütfen Tekrar Deneyin";
    }
  }

  validateAdminStatus() {
    for (int i = 0; i < userList.length; i++) {
      if ((userList[i].userPassword == user.userPassword) &&
          (userList[i].userName == user.userName)) {
        user.userAdminStatus = userList[i].userAdminStatus;
        user.id = userList[i].id;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Giriş Sayfası"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              buildUserNameFeild(),
              buildPasswordFeild(),
              buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserNameFeild() {
    return TextFormField(
      initialValue: user.userName,
      decoration:
          InputDecoration(labelText: "Kullanıcı Adı", hintText: "admin"),
      validator: validateUserName,
      onSaved: (String value) {
        user.userName = value;
      },
    );
  }

  Widget buildPasswordFeild() {
    return TextFormField(
      initialValue: user.userPassword,
      decoration:
          InputDecoration(labelText: "Kullanıcı Şifresi", hintText: "root"),
      validator: validatePassword,
      onSaved: (String value) {
        user.userPassword = value;
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Giriş Yap"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          validateAdminStatus();
          print("islembasarili");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Islemler(user)),
              (Route<dynamic> route) => false);
        }
      },
    );
  }
}

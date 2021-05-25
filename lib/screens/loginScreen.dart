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
  var users = Users();
  var formKey = GlobalKey<FormState>();
  var userList = List<Users>();

  DatabaseHelper dbhelper = DatabaseHelper();
  @override
  void initState() {
    fetchh();
    super.initState();
  }

  Future<void> fetchh() async {
    var temp = await getListOfUsers();
    setState(() {
      userList = temp;
    });
  }

  Future<List<Users>> getListOfUsers() async {
    var userList = await dbhelper.getUsersList();
    var users = userList;
    if (users != null) {
      return users;
    }
  }

  String validateUserName(String value) {
    if (!(userList.any((e) => e.userName !=value))) {
      return "Kullanıcı Adınız Yanlış, Lütfen Tekrar Deneyin";
    }
    return null;
  }

  String validatePassword(String value) {
    if (!(userList.any((e) => e.userPassword !=value))) {
      return "Şifreniz Yanlış, Lütfen Tekrar Deneyin";
    }
    return null;
  }

  validateAdminStatus() {
    for (int i = 0; i < userList.length; i++) {
      if (userList[i].userPassword == users.userPassword &&
          userList[i].userName == users.userName) {
        users.userAdminStatus = userList[i].userAdminStatus;
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
            children: <Widget>[
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
      initialValue: users.userName,
      decoration:
          InputDecoration(labelText: "Kullanıcı Adı", hintText: "admin"),
      validator: validateUserName,
      onSaved: (String value) {
        users.userName = value;
      },
    );
  }

  Widget buildPasswordFeild() {
    return TextFormField(
      initialValue: users.userPassword,
      decoration:
          InputDecoration(labelText: "Kullanıcı Şifresi", hintText: "root"),
      validator: validatePassword,
      onSaved: (String value) {
        users.userPassword = value;
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
              MaterialPageRoute(builder: (context) => Islemler(users)),
              (Route<dynamic> route) => true);
        }
      },
    );
  }
}

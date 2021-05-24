import 'package:flutter/material.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:untitled1/utis/dbhelper.dart';
import 'validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State{
  var users = Users();
  var formKey = GlobalKey<FormState>();


  DatabaseHelper dbhelper = DatabaseHelper();
  @override
  void initState() {
    fetchh();
    super.initState();
  }

  Future<void> fetchh() async {
    var temp = await getListOfUsers();
    setState(() {
      listee = temp;
    });
  }
  Future<List<Users>> getListOfUsers() async {
    var userList = await dbhelper.getUsersList();
    var users = userList;
    if (users != null) {
      return users;
    }
  }

  getUsers() async {
    var currentUsers = await dbhelper.getUsersList();
    return currentUsers;
  }
  bool idStatus = false;
  bool passStatus = false;

  String validateUserName(String value){
    List<Users> defUsers = getUsers();
    for(int i = 0;i<defUsers.length;i++){
      if (value == defUsers[i].userName) {
        idStatus = true;
      }
    }
    if(idStatus){
      return "Kullanıcı Adınız Yanlış, Lütfen Tekrar Deneyin";
    }
  }
  String validatePassword(String value){
    List<Users> defUsers = getUsers();
    for(int i = 0;i<defUsers.length;i++){
      if (value == defUsers[i].userName) {
        idStatus = true;
      }
    }
    if(passStatus){
      return "Şifreniz Yanlış, Lütfen Tekrar Deneyin";
    }
  }
  String validateGrade(String value){
    var grade = int.parse(value);
    if ( grade < 0 || grade > 100 ){
      return "Not 0 ile 100 arasında olmalıdır";
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Öğrenci Ekle"),
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
          Navigator.pop(context);
        }
      },
    );
  }
}

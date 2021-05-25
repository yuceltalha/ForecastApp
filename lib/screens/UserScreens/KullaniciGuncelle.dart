import 'package:flutter/material.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:untitled1/screens/LocationScreens/lokasyonDuzenle.dart';
import 'package:untitled1/utis/dbhelper.dart';

class KullaniciGuncelle extends StatefulWidget {
  var user = Users();
  KullaniciGuncelle(user) {
    this.user;
  }
  @override
  State<StatefulWidget> createState() {
    return _KullaniciGuncelleState(user);
  }
}

class _KullaniciGuncelleState extends State {
  var formKey = GlobalKey<FormState>();
  var userList = List<Users>();
  DatabaseHelper dbhelper = DatabaseHelper();
  var user = Users();
  _KullaniciGuncelleState(user) {
    this.user;
  }
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

  getUsers() async {
    var currentUsers = await dbhelper.getUsersList();
    return currentUsers;
  }

  //silinecek
  String validateLoc(String value) {
    if (value.length < 2) {
      return "Lokasyon Adı 2 harften uzun olmalı";
    }
  }

  String validateApi(String value) {
    if (value.length < 2) {
      return "Api Adı 2 harften uzun olmalı";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: false,
        title: Text("Lokasyon Güncelleme Sayfası"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              buildLocNameFeild(),
              buildLocApiFeild(),
              buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLocNameFeild() {
    return TextFormField(
      initialValue: user.userName,
      decoration:
      InputDecoration(labelText: "Kullanıcı Adı", hintText: "admin"),
      onSaved: (String value) {
        user.userName = value;
      },
    );
  }

  Widget buildLocApiFeild() {
    return TextFormField(
      initialValue: user.userPassword,
      decoration:
      InputDecoration(labelText: "Kullanıcı Şifresi", hintText: "root"),
      onSaved: (String value) {
        user.userPassword = value;
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Lokasyon Ekle"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          dbhelper.updateU(user);
          print("islembasarili");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LokasyonDuzenle()),
                  (Route<dynamic> route) => true);
        }
      },
    );
  }
}

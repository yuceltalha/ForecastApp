import 'package:flutter/material.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:untitled1/utis/dbhelper.dart';

import 'kullaniciDuzenle.dart';

class KullaniciEkle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _KullaniciEkleState();
  }
}

class _KullaniciEkleState extends State {
  var formKey = GlobalKey<FormState>();
  var userList = List<Users>();
  DatabaseHelper dbhelper = DatabaseHelper();
  var user = Users();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: false,
        title: Text("Kullanıcı Ekleme Sayfası"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              buildLocNameFeild(),
              buildLocApiFeild(),
              buildUserAuthFeild(),
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

  bool isSwitched = false;
  Widget buildUserAuthFeild() {
    return Row(
      children: [
        Text(
          "Tanrı Kullanıcı = "
        ),
        Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
          },
          activeTrackColor: Colors.yellow,
          activeColor: Colors.orangeAccent,
        ),
      ],
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Lokasyon Ekle"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          user.id = null;
          if (isSwitched) {
            user.userAdminStatus = 1;
          } else {
            user.userAdminStatus = 0;
          }
          dbhelper.insertU(user);
          print("islembasarili");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => KullaniciDuzenle()),
              (Route<dynamic> route) => false);
        }
      },
    );
  }
}

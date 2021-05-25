import 'package:flutter/material.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:untitled1/screens/LocationScreens/lokasyonDuzenle.dart';
import 'package:untitled1/screens/islemMenusu.dart';
import 'package:untitled1/utis/dbhelper.dart';

class KullaniciGuncelle extends StatefulWidget {
  var user = Users();
  KullaniciGuncelle(user) {
    this.user = user;
  }
  @override
  State<StatefulWidget> createState() {
    return _KullaniciGuncelleState(user);
  }
}

class _KullaniciGuncelleState extends State {
  var formKey = GlobalKey<FormState>();
  DatabaseHelper dbhelper = DatabaseHelper();
  var user = Users();
  _KullaniciGuncelleState(user) {
    this.user = user;
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
      child: Text("Kullanıcı Ekle"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          dbhelper.updateU(user);
          print("islembasarili");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Islemler(user)),
                  (Route<dynamic> route) => false);
        }
      },
    );
  }
}

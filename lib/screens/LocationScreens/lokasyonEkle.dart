import 'package:flutter/material.dart';
import 'package:untitled1/models/locationsModel.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:untitled1/screens/LocationScreens/lokasyonDuzenle.dart';
import 'package:untitled1/screens/islemMenusu.dart';
import 'package:untitled1/utis/dbhelper.dart';

class LokasyonEkle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LokasyonEkleState();
  }
}

class _LokasyonEkleState extends State {
  var formKey = GlobalKey<FormState>();
  var location = Locations();
  DatabaseHelper dbhelper = DatabaseHelper();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: false,
        title: Text("Lokasyon Ekleme Sayfası"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
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
      initialValue: location.locationName,
      decoration:
          InputDecoration(labelText: "Lokasyon Adı", hintText: "İstanbul"),
      onSaved: (String value) {
        location.locationName = value;
      },
    );
  }

  Widget buildLocApiFeild() {
    return TextFormField(
      initialValue: location.locationApiName,
      decoration:
          InputDecoration(labelText: " Yanlızca Lokasyon Kodunu Giriniz", hintText: "IARNAVUT2"),
      onSaved: (String value) {
        location.locationApiName =value;
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Lokasyon Ekle"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          location.id = null;
          location.userId = 1;
          dbhelper.insertLocation(location);
          var user = Users();
          user.userAdminStatus =1;
          user.id = 1;
          user.userPassword = "root";
          user.userName ="admin";
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Islemler(user)),
              (Route<dynamic> route) => true);
        }
      },
    );
  }
}

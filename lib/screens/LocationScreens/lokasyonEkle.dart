import 'package:flutter/material.dart';
import 'package:untitled1/models/locationsModel.dart';
import 'package:untitled1/screens/LocationScreens/lokasyonDuzenle.dart';
import 'package:untitled1/utis/dbhelper.dart';

class LokasyonEkle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LokasyonEkleState();
  }
}

class _LokasyonEkleState extends State {
  var formKey = GlobalKey<FormState>();
  var LocList = List<Locations>();
  var location = Locations();
  DatabaseHelper dbhelper = DatabaseHelper();
  @override
  void initState() {
    fetchh();
    super.initState();
  }

  Future<void> fetchh() async {
    var temp = await getListOfLocations();
    setState(() {
      LocList = temp;
    });
  }

  Future<List<Locations>> getListOfLocations() async {
    var userList = await dbhelper.getLocationsList();
    var locs = LocList;
    if (locs != null) {
      return locs;
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
        title: Text("Lokasyon Ekleme Sayfası"),
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
          InputDecoration(labelText: " Api Kodu", hintText: "IARNAVUT2"),
      onSaved: (String value) {
        location.locationApiName = "";
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
          var res = dbhelper.insertLocation(location);
          print("islembasarili" + res.toString());
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LokasyonDuzenle()),
              (Route<dynamic> route) => false);
        }
      },
    );
  }
}

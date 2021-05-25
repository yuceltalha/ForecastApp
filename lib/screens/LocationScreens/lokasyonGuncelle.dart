import 'package:flutter/material.dart';
import 'package:untitled1/models/locationsModel.dart';
import 'package:untitled1/utis/dbhelper.dart';

class LokasyonGuncelle extends StatefulWidget {
  var location = Locations();
  LokasyonGuncelle(location) {
    this.location = location;
  }
  @override
  State<StatefulWidget> createState() {
    return _LokasyonGuncelleState(location);
  }
}

class _LokasyonGuncelleState extends State {
  var formKey = GlobalKey<FormState>();
  DatabaseHelper dbhelper = DatabaseHelper();
  var location = Locations();
  _LokasyonGuncelleState(location) {
    this.location = location;
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
      decoration: InputDecoration(
          labelText: " Yanlızca Apinin Lokasyon Kodunu Giriniz",
          hintText: "IARNAVUT2"),
      onSaved: (String value) {
        location.locationApiName = value;
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Lokasyon Ekle"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          dbhelper.updateL(location);
          Navigator.pop(context);
        }
      },
    );
  }
}

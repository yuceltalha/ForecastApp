import 'package:flutter/material.dart';
import 'package:untitled1/models/locationsModel.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:untitled1/screens/raporlar.dart';
import 'package:untitled1/utis/dbhelper.dart';

class HavaDurumuSorgu extends StatefulWidget {
  var user = Users();
  HavaDurumuSorgu(user) {
    this.user = user;
  }
  @override
  State<StatefulWidget> createState() {
    return _HavaDurumuSorguState(user);
  }
}

class _HavaDurumuSorguState extends State {
  DatabaseHelper dbhelper = DatabaseHelper();
  var user = Users();
  _HavaDurumuSorguState(user) {
    this.user = user;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hava Durumu Sorgulama"),
      ),
      body: forecastBuilder(),
    );
  }

  forecastBuilder() {
    return FutureBuilder<List<Locations>>(
        future: dbhelper.getLocationsList(),
        builder: (context, AsyncSnapshot<List<Locations>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("hata!"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int position) {
                  return Container(
                    margin: EdgeInsets.all(7),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.deepPurple.shade200,
                      elevation: 2.4,
                      child: ListTile(
                        title: Text(snapshot.data[position].locationName +
                            " Lokasyonu"),
                        onTap: () {
                          setState(() {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Raporlar(snapshot.data[position],user),
                                ),
                                (Route<dynamic> route) => true);
                          });
                        },
                      ),
                    ),
                  );
                });
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text("else girdi");
          }
        });
  }
}

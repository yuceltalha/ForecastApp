import 'package:flutter/material.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:untitled1/screens/LocationScreens/lokasyonEkle.dart';
import 'package:untitled1/utis/dbhelper.dart';

import 'KullaniciGuncelle.dart';

class KullaniciDuzenle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _KullaniciDuzenleState();
  }
}

class _KullaniciDuzenleState extends State {
  DatabaseHelper dbhelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //lokasyon ekle
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LokasyonEkle()),
              (Route<dynamic> route) => true);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Kullanıcılar"),
      ),
      body: locationBuilder(),
    );
  }

  locationBuilder() {
    return FutureBuilder<List<Users>>(
        future: dbhelper.getUsersList(),
        builder: (context, AsyncSnapshot<List<Users>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("hata!"),
            );
          } else if (snapshot.hasData) {
            return Expanded(
              child: ListView.builder(
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
                          title: Text(" Kullanıcı Adı: " +
                              snapshot.data[position].userName),
                          onTap: () {
                            setState(() {
                              if (snapshot.data[position].userName != "admin" &&
                                  snapshot.data[position].userPassword !=
                                      "root") {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => KullaniciGuncelle(
                                            snapshot.data[position])),
                                    (Route<dynamic> route) => true);
                              }
                            });
                          },
                        ),
                      ),
                    );
                  }),
            );
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

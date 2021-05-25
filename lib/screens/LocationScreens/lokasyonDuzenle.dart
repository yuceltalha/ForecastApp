import 'package:flutter/material.dart';
import 'package:untitled1/models/locationsModel.dart';
import 'package:untitled1/utis/dbhelper.dart';
import 'lokasyonEkle.dart';
import 'lokasyonGuncelle.dart';

class LokasyonDuzenle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LokasyonDuzenleState();
  }
}

class _LokasyonDuzenleState extends State{

  DatabaseHelper dbhelper = DatabaseHelper();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //lokasyon ekle
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LokasyonEkle()),
                  (Route<dynamic> route) => true);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Lokasyonlar"),
      ),
      body: locationBuilder(),
    );
  }


  locationBuilder() {
    return FutureBuilder<List<Locations>>(
        future: dbhelper.getLocationsList(),
        builder: (context, AsyncSnapshot<List<Locations>> snapshot) {
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
                          title: Text(snapshot.data[position].locationName + " Lokasyonu"),
                          onTap: () {
                            setState(() {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => LokasyonGuncelle(snapshot.data[position])),
                                      (Route<dynamic> route) => true);
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
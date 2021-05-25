import 'package:flutter/material.dart';
import 'package:untitled1/models/locationsModel.dart';
import 'package:untitled1/models/userLogModel.dart';
import 'package:untitled1/screens/raporlar.dart';
import 'package:untitled1/utis/dbhelper.dart';

class ULogScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ULogScreenState();
  }
}

class _ULogScreenState extends State {
  DatabaseHelper dbhelper = DatabaseHelper();

  var user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıtlar Sayfası"),
      ),
      body: logBuilder(),
    );
  }

  logBuilder() {
    return Column(
      children: [
        FutureBuilder<List<UserLog>>(
            future: dbhelper.getLogist(),
            builder: (context, AsyncSnapshot<List<UserLog>> snapshot) {
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
                              title: Text("Kullanıcı id " +
                                  "\n" +
                                  snapshot.data[position].userId.toString() +
                                  "Kullanıcı Ip " +
                                  "\n" +
                                  snapshot.data[position].kullaniciIp +
                                  "Sorgulama Durumu " +
                                  "\n" +
                                  snapshot.data[position].sorgulamaDurumu +
                                  "Sorgu Lokasyonu " +
                                  "\n" +
                                  snapshot.data[position].sorguLokasyon +
                                  "Sorgulama Zamanı " +
                                  "\n" +
                                  snapshot.data[position].sorguZaman +
                                  "Cevap Süresi " +
                                  "\n" +
                                  snapshot.data[position].reponseTime.toString() +
                                  "Sorgulama Sonucu " +
                                  "\n" +
                                  snapshot.data[position].sorguSonucu),
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
                return Text("Veri Yok");
              }
            }),
      ],
    );
  }
}

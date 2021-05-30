import 'package:flutter/material.dart';
import 'package:untitled1/models/userLogModel.dart';
import 'package:untitled1/utis/dbhelper.dart';

class ULogScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ULogScreenState();
  }
}

class _ULogScreenState extends State {
  DatabaseHelper dbhelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıtlar Sayfası"),
      ),
      body: logBuilder(),
    );
  }

  setColor(int id) {
    if (id % 2 == 0) {
      return Colors.blue.shade400;
    } else {
      return Colors.deepOrange.shade200;
    }
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
                          color: setColor(snapshot.data.length),
                          margin: EdgeInsets.all(7),
                          child: Column(
                            children: [
                              Card(
                                child: ListTile(
                                  title: Text("Kullanıcı id : " +
                                      snapshot.data[position].userId
                                          .toString()),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: Text("Kullanıcı Ip : " +
                                      snapshot.data[position].kullaniciIp
                                          .toString()),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: Text("Sorgulama Durumu : " +
                                      snapshot.data[position].sorgulamaDurumu
                                          .toString()),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: Text("Sorgu Lokasyonu :" +
                                      snapshot.data[position].sorguLokasyon
                                          .toString()),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: Text("Sorgulama Zamanı :" +
                                      snapshot.data[position].sorguZaman
                                          .toString()),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: Text("Cevap Süresi : " +
                                      snapshot.data[position].responseTime
                                          .toString()),
                                ),
                              ),
                              Card(
                                  child: ListTile(
                                title: Text(
                                  "Sorgulama Sonucu : " +
                                      snapshot.data[position].sorguSonucu
                                          .toString(),
                                ),
                              )),
                            ],
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

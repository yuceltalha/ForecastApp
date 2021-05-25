import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:untitled1/models/forecastModel.dart';
import 'package:untitled1/models/locationsModel.dart';
import 'package:untitled1/utis/dbhelper.dart';
import 'package:http/http.dart' as http;

class Raporlar extends StatefulWidget {
  var location = Locations();
  Raporlar(location) {
    this.location = location;
  }
  @override
  State<StatefulWidget> createState() {
    return _RaporlarState(location);
  }
}

class _RaporlarState extends State {
  DatabaseHelper dbhelper = DatabaseHelper();
  var location = Locations();
  _RaporlarState(location) {
    this.location = location;
  }

  final String base = "https://api.weather.com/v2/pws/observations/current?format=json&units=e&apiKey=1461aaaed21e438da1aaaed21e738d06";


  Future<Observations> ApiCall() async {
    print(location.locationApiName);

    final response = await http.get(Uri.parse(
        "${base}&stationId=${location.locationApiName}"));

    if (response.statusCode == 200) {
      return Observations.fromJson(json.decode(response.body));
    } else {
      throw Exception("hata!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sonuç Sayfası"),
      ),
      body: reportBuilder(),
    );
  }

  reportBuilder() {
    return FutureBuilder<Observations>(
        future: ApiCall(),
        builder: (context, AsyncSnapshot<Observations> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("hata!"),
            );
          } else if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Text("ÜLKE KODU : " +
                          snapshot.data.observations[0].country),
                      Text("BÖLGE : " +
                          snapshot.data.observations[0].neighborhood),
                      Text("BÖLGE APİ KODU : " +
                          snapshot.data.observations[0].stationId),
                      Text("SORGULAMA ZAMANI : " +
                          snapshot.data.observations[0].obsTimeLocal
                              .toString()),
                    ],
                  ),
                ),
              ],
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text("Veri Yok");
          }
        });
  }
}

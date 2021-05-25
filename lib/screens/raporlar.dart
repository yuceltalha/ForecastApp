import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ip/flutter_ip.dart';
import 'package:untitled1/models/forecastModel.dart';
import 'package:untitled1/models/locationsModel.dart';
import 'package:untitled1/models/userLogModel.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:untitled1/utis/dbhelper.dart';
import 'package:http/http.dart' as http;

class Raporlar extends StatefulWidget {
  var location = Locations();
  var user = Users();
  Raporlar(location, user) {
    this.location = location;
    this.user = user;
  }
  @override
  State<StatefulWidget> createState() {
    return _RaporlarState(location, user);
  }
}

class _RaporlarState extends State {
  var date = DateTime.now();
  int responseTime = 0;
  var userLog = UserLog();

  DatabaseHelper dbhelper = DatabaseHelper();
  var location = Locations();
  var user = Users();
  String external;
  _RaporlarState(location, user) {
    this.location = location;
    this.user = user;
  }

  userLogging(String temp, String wind, String country) {
    userLog.id = null;
    userLog.userId = user.id;
    userLog.sorguZaman = date.toString();
    userLog.sorguLokasyon =
        location.locationName + "  " + location.locationApiName;
    userLog.sorguSonucu =
        "SICAKLIK : " + temp + "\n  RÜZGAR " + wind + "\n ÜLKE KODU " + country;
  }

  final String base =
      "https://api.weather.com/v2/pws/observations/current?format=json&units=e&apiKey=1461aaaed21e438da1aaaed21e738d06";

  Future<Observations> ApiCall() async {
    responseTime = date.second*100 + date.millisecond;
    final response = await http
        .get(Uri.parse("https://api.weather.com/v2/pws/observations/current?format=json&units=e&apiKey=1461aaaed21e438da1aaaed21e738d06&stationId=${location.locationApiName}"));

    if (response.statusCode == 200) {
      print(location.locationApiName);
      print(responseTime);
      external = await FlutterIp.externalIP;
      return Observations.fromJson(json.decode(response.body));
    } else {
      external = await FlutterIp.externalIP;
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
            userLog.sorgulamaDurumu = "Başarısız";
            userLogging("temp", "wind", "country");
            return Center(
              child: Text("hataa!"),
            );
          } else if (snapshot.hasData) {
            userLog.sorgulamaDurumu = "Başarılı";
            responseTime =
                (date.second * 100 + date.millisecond) - responseTime;
            userLog.reponseTime = responseTime;
            userLog.kullaniciIp = external;
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
                      Text("SICAKLIK : " +
                          snapshot.data.observations[0].imperial["temp"]
                              .toString()),
                      Text("RÜZGAR HIZI : " +
                          snapshot.data.observations[0].imperial["windSpeed"]
                              .toString()),
                      userLogging(
                          snapshot.data.observations[0].imperial["temp"]
                              .toString(),
                          snapshot.data.observations[0].imperial["windSpeed"]
                              .toString(),
                          snapshot.data.observations[0].country)
                    ],
                  ),
                ),
              ],
            );
          } else if (!snapshot.hasData) {
            userLog.sorgulamaDurumu = "Başarısız";
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text("Veri Yok");
          }
        });
  }
}

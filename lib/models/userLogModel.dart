// To parse this JSON data, do
//
//     final userLog = userLogFromJson(jsonString);

import 'dart:convert';

UserLog userLogFromJson(String str) => UserLog.fromJson(json.decode(str));

String userLogToJson(UserLog data) => json.encode(data.toJson());

class UserLog {
  UserLog({
    this.id,
    this.userId,
    this.sorguZaman,
    this.sorguLokasyon,
    this.kullaniciIp,
    this.sorguSonucu,
    this.reponseTime,
    this.sorgulamaDurumu,
  });

  int id;
  int userId;
  String sorguZaman;
  String sorguLokasyon;
  String kullaniciIp;
  String sorguSonucu;
  int reponseTime;
  String sorgulamaDurumu;

  factory UserLog.fromJson(Map<String, dynamic> json) => UserLog(
    id: json["ID"],
    userId: json["userID"],
    sorguZaman: json["sorguZaman"],
    sorguLokasyon: json["sorguLokasyon"],
    kullaniciIp: json["kullaniciIP"],
    sorguSonucu: json["sorguSonucu"],
    reponseTime: json["reponseTime"],
    sorgulamaDurumu: json["sorgulamaDurumu"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "userID": userId,
    "sorguZaman": sorguZaman,
    "sorguLokasyon": sorguLokasyon,
    "kullaniciIP": kullaniciIp,
    "sorguSonucu": sorguSonucu,
    "reponseTime": reponseTime,
    "sorgulamaDurumu": sorgulamaDurumu,
  };
}

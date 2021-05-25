// To parse this JSON data, do
//
//     final locations = locationsFromJson(jsonString);

import 'dart:convert';

Locations locationsFromJson(String str) => Locations.fromJson(json.decode(str));

String locationsToJson(Locations data) => json.encode(data.toJson());

class Locations {
  Locations({
    this.id,
    this.locationName,
    this.locationApiName,
    this.userId,
  });

  int id;
  String locationName;
  String locationApiName;
  int userId;

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
    id: json["id"],
    locationName: json["locationName"],
    locationApiName: json["locationApiName"],
    userId: json["userID"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "locationName": locationName,
    "locationApiName": locationApiName,
    "userID": userId,
  };
}

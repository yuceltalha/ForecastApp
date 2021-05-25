// To parse this JSON data, do
//
//     final observations = observationsFromJson(jsonString);

import 'dart:convert';

Observations observationsFromJson(String str) => Observations.fromJson(json.decode(str));

String observationsToJson(Observations data) => json.encode(data.toJson());

class Observations {
  Observations({
    this.observations,
  });

  List<Observation> observations;

  factory Observations.fromJson(Map<String, dynamic> json) => Observations(
    observations: List<Observation>.from(json["observations"].map((x) => Observation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "observations": List<dynamic>.from(observations.map((x) => x.toJson())),
  };
}

class Observation {
  Observation({
    this.stationId,
    this.obsTimeUtc,
    this.obsTimeLocal,
    this.neighborhood,
    this.softwareType,
    this.country,
    this.solarRadiation,
    this.lon,
    this.realtimeFrequency,
    this.epoch,
    this.lat,
    this.uv,
    this.winddir,
    this.humidity,
    this.qcStatus,
    this.imperial,
  });

  String stationId;
  DateTime obsTimeUtc;
  DateTime obsTimeLocal;
  String neighborhood;
  String softwareType;
  String country;
  dynamic solarRadiation;
  double lon;
  dynamic realtimeFrequency;
  int epoch;
  double lat;
  dynamic uv;
  int winddir;
  int humidity;
  int qcStatus;
  Map<String, double> imperial;

  factory Observation.fromJson(Map<String, dynamic> json) => Observation(
    stationId: json["stationID"],
    obsTimeUtc: DateTime.parse(json["obsTimeUtc"]),
    obsTimeLocal: DateTime.parse(json["obsTimeLocal"]),
    neighborhood: json["neighborhood"],
    softwareType: json["softwareType"],
    country: json["country"],
    solarRadiation: json["solarRadiation"],
    lon: json["lon"].toDouble(),
    realtimeFrequency: json["realtimeFrequency"],
    epoch: json["epoch"],
    lat: json["lat"].toDouble(),
    uv: json["uv"],
    winddir: json["winddir"],
    humidity: json["humidity"],
    qcStatus: json["qcStatus"],
    imperial: Map.from(json["imperial"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "stationID": stationId,
    "obsTimeUtc": obsTimeUtc.toIso8601String(),
    "obsTimeLocal": obsTimeLocal.toIso8601String(),
    "neighborhood": neighborhood,
    "softwareType": softwareType,
    "country": country,
    "solarRadiation": solarRadiation,
    "lon": lon,
    "realtimeFrequency": realtimeFrequency,
    "epoch": epoch,
    "lat": lat,
    "uv": uv,
    "winddir": winddir,
    "humidity": humidity,
    "qcStatus": qcStatus,
    "imperial": Map.from(imperial).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
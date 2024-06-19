// To parse this JSON data, do
//
//     final modelKampus = modelKampusFromJson(jsonString);

import 'dart:convert';

ModelKampus modelKampusFromJson(String str) => ModelKampus.fromJson(json.decode(str));

String modelKampusToJson(ModelKampus data) => json.encode(data.toJson());

class ModelKampus {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelKampus({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelKampus.fromJson(Map<String, dynamic> json) => ModelKampus(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String? nama_kampus;
  String? lokasi_kampus;
  String? gambar_kampus;
  String? lat_kampus;
  String? long_kampus;
  String? profile_kampus;

  Datum({
    required this.id,
    this.nama_kampus,
    this.lokasi_kampus,
    this.gambar_kampus,
    this.lat_kampus,
    this.long_kampus,
    this.profile_kampus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nama_kampus: json["nama_kampus"],
    lokasi_kampus: json["lokasi_kampus"],
    gambar_kampus: json["gambar_kampus"],
    lat_kampus: json["lat_kampus"],
    long_kampus: json["long_kampus"],
    profile_kampus: json["profile_kampus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_kampus": nama_kampus,
    "lokasi_kampus": lokasi_kampus,
    "gambar_kampus": gambar_kampus,
    "lat_kampus": lat_kampus,
    "long_kampus": long_kampus,
    "profile_kampus": profile_kampus,
  };
}

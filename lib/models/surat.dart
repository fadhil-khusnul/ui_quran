// To parse this JSON data, do
//
//     final surah = surahFromJson(jsonString);

import 'dart:convert';

import 'package:ui_quran/models/ayat.dart';

Surah surahFromJson(String str) => Surah.fromJson(json.decode(str));

String surahToJson(Surah data) => json.encode(data.toJson());

class Surah {
  int code;
  String message;
  List<Datum> data;

  Surah({
    required this.code,
    required this.message,
    required this.data,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  TempatTurun tempatTurun;
  String arti;
  String deskripsi;
  Map<String, String> audioFull;
  List<Ayat>? ayat;

  Datum({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
     this.ayat,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      nomor: json["nomor"],
      nama: json["nama"],
      namaLatin: json["namaLatin"],
      jumlahAyat: json["jumlahAyat"],
      tempatTurun: tempatTurunValues.map[json["tempatTurun"]]!,
      arti: json["arti"],
      deskripsi: json["deskripsi"],
      audioFull: Map.from(json["audioFull"])
          .map((k, v) => MapEntry<String, String>(k, v)),
      ayat: json.containsKey('ayat')
          ? List<Ayat>.from(json["ayat"].map((x) => Ayat.fromJson(x)))
          : null);

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "namaLatin": namaLatin,
        "jumlahAyat": jumlahAyat,
        "tempatTurun": tempatTurunValues.reverse[tempatTurun],
        "arti": arti,
        "deskripsi": deskripsi,
        "audioFull":
            Map.from(audioFull).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "ayat":
            ayat != null ? List<dynamic>.from(ayat!.map((e) => e.toJson())) : []
      };
}

enum TempatTurun { MADINAH, MEKAH }

final tempatTurunValues =
    EnumValues({"Madinah": TempatTurun.MADINAH, "Mekah": TempatTurun.MEKAH});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

// To parse this JSON data, do
//
//     final registerEnf = registerEnfFromMap(jsonString);

import 'dart:convert';

class RegisterEnf {
  RegisterEnf({
    required this.registerEnf,
  });

  RegisterEnfClass registerEnf;

  factory RegisterEnf.fromJson(String str) =>
      RegisterEnf.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterEnf.fromMap(Map<String, dynamic> json) => RegisterEnf(
        registerEnf: RegisterEnfClass.fromMap(json["registerEnf"]),
      );

  Map<String, dynamic> toMap() => {
        "registerEnf": registerEnf.toMap(),
      };
}

class RegisterEnfClass {
  RegisterEnfClass({
    required this.enfermedad,
    required this.fecha,
    required this.fotografia,
    required this.tratamiento,
  });

  String enfermedad;
  String fecha;
  String fotografia;
  String tratamiento;

  String? id;

  factory RegisterEnfClass.fromJson(String str) =>
      RegisterEnfClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterEnfClass.fromMap(Map<String, dynamic> json) =>
      RegisterEnfClass(
        enfermedad: json["enfermedad"],
        fecha: json["fecha"],
        fotografia: json["fotografia"],
        tratamiento: json["tratamiento"],
      );

  Map<String, dynamic> toMap() => {
        "enfermedad": enfermedad,
        "fecha": fecha,
        "fotografia": fotografia,
        "tratamiento": tratamiento,
      };
}

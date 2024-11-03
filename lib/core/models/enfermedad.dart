// To parse this JSON data, do
//
//     final enfermedad = enfermedadFromMap(jsonString);

import 'dart:convert';

class Enfermedad {
  Enfermedad({
    required this.info,
    required this.results,
  });

  Info info;
  List<Result> results;

  factory Enfermedad.fromJson(String str) =>
      Enfermedad.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Enfermedad.fromMap(Map<String, dynamic> json) => Enfermedad(
        info: Info.fromMap(json["info"]),
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "info": info.toMap(),
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Info {
  Info({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  int? count;
  int? pages;
  dynamic next;
  dynamic prev;

  factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Info.fromMap(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class Result {
  Result({
    this.id,
    this.name,
    this.descripcion,
    this.code,
    this.tratamiento,
    this.precauciones,
    this.created,
  });

  int? id;
  String? name;
  String? descripcion;
  String? code;
  List<Tratamiento>? tratamiento;
  List<Precaucione>? precauciones;
  DateTime? created;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        descripcion: json["descripcion"],
        code: json["code"],
        tratamiento: List<Tratamiento>.from(
            json["tratamiento"].map((x) => Tratamiento.fromMap(x))),
        precauciones: List<Precaucione>.from(
            json["precauciones"].map((x) => Precaucione.fromMap(x))),
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "descripcion": descripcion,
        "code": code,
        "tratamiento": List<dynamic>.from(tratamiento!.map((x) => x.toMap())),
        "precauciones": List<dynamic>.from(precauciones!.map((x) => x.toMap())),
        "created": created!.toIso8601String(),
      };
}

class Precaucione {
  Precaucione({
    required this.atencion,
    required this.id,
  });

  String atencion;
  String id;

  factory Precaucione.fromJson(String str) =>
      Precaucione.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Precaucione.fromMap(Map<String, dynamic> json) => Precaucione(
        atencion: json["atencion"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "atencion": atencion,
        "id": id,
      };
}

class Tratamiento {
  Tratamiento({
    required this.id,
    required this.nombre,
    required this.dosis,
  });

  String id;
  String nombre;
  List<Dosi> dosis;

  factory Tratamiento.fromJson(String str) =>
      Tratamiento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tratamiento.fromMap(Map<String, dynamic> json) => Tratamiento(
        id: json["id"],
        nombre: json["nombre"],
        dosis: List<Dosi>.from(json["dosis"].map((x) => Dosi.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "dosis": List<dynamic>.from(dosis.map((x) => x.toMap())),
      };
}

class Dosi {
  Dosi({
    required this.id,
    required this.aplicacion,
  });

  String id;
  String aplicacion;

  factory Dosi.fromJson(String str) => Dosi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Dosi.fromMap(Map<String, dynamic> json) => Dosi(
        id: json["id"],
        aplicacion: json["aplicacion"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "aplicacion": aplicacion,
      };
}

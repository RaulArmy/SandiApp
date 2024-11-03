import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:sandiapp/core/models/enfermedad_register.dart';

class DataEnfermedad {
  static DataEnfermedad instance = DataEnfermedad._internal();

  factory DataEnfermedad() {
    return instance;
  }

  DataEnfermedad._internal();

  final String _baseUrl = 'sandiapp-47455-default-rtdb.firebaseio.com';

  final List<RegisterEnfClass> registerEnferme = [];

//metodo para cargar un producto desde la base de datos a la lista
  Future<List<RegisterEnfClass>> readRequiredData() async {
    final url = Uri.https(_baseUrl, 'infnutricion.json');
    final respuesta = await http.get(url);

    final Map<String, dynamic> nutricionMapeadas = json.decode(respuesta.body);

    nutricionMapeadas.forEach((key, value) {
      final enfeTem = RegisterEnfClass.fromMap(value);
      enfeTem.id = key;
      registerEnferme.add(enfeTem); //agrega a la lista de productos
    });

    return registerEnferme;
  }

  Future<String> saveRegisterEnfe(RegisterEnfClass curren) async {
    final url = Uri.https(_baseUrl, 'pedido.json');
    final resp = await http.post(url, body: curren.toJson());
    final decodedData = json.decode(resp.body);

    curren.id = decodedData['name'];

    registerEnferme.add(curren);

    return curren.id!;
  }
}

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sandiapp/core/models/enfermedad.dart';

import 'controller_ia_ctr.dart';

class DataLocal extends GetxController {
  static DataLocal initializeController() {
    try {
      DataLocal controller = Get.find<DataLocal>();
      return controller;
    } catch (e) {
      DataLocal controller = Get.put(DataLocal());
      return controller;
    }
  }

  final IAController _iaController = IAController.initializeController();

  RxList lisEnfermedades = [].obs; //todas las enfermedades
  RxMap enfermedad = <String, dynamic>{}.obs; // una enfermedad
  Rx<Result> objData = Result().obs;

  Future<String> _loadDataAsset() async {
    return await rootBundle.loadString('assets/plagas.json');
  }

  Future loadProduct() async {
    resetData();
    String jsonEnferm = await _loadDataAsset();
    Map<String, dynamic> jsonResponse = json.decode(jsonEnferm);

    for (var element in jsonResponse.entries) {
      if (element.key == 'results') {
        lisEnfermedades.value = element.value;
      }
    }
    searhData(_iaController.prediction.value);
  }

  void resetData() {
    lisEnfermedades.clear();
    enfermedad = <String, dynamic>{}.obs;
    objData = Result().obs;
  }

  void searhData(String name) {
    // ignore: invalid_use_of_protected_member
    for (Map element in lisEnfermedades.value) {
      if (element['name'] == name) {
        enfermedad.value = element;
      }
    }
    if (enfermedad.isNotEmpty) {
      objData.value = converData();
      print(objData);
    }
  }

  Result converData() {
    final result = Result.fromMap(enfermedad.toJson());
    return result;
  }
}

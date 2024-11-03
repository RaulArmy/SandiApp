import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:sandiapp/app/ui/controller/shared_ctr.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:image/image.dart' as img;

import '../../../core/IA/clasificacionImg.dart';

class IAController extends GetxController {
  static IAController initializeController() {
    try {
      IAController controller = Get.find<IAController>();
      return controller;
    } catch (e) {
      IAController controller = Get.put(IAController());
      return controller;
    }
  }

  final SharedController _sharedController =
      SharedController.initializeController();

  late Classifier classifier;
  final picker = ImagePicker();
  RxList<XFile>? _imageFileList = <XFile>[].obs;
  var logger = Logger();
  Category? category;
  Rx<File?> image = File('').obs;
  RxString prediction = "Tome una foto".obs;

  RxBool isPredic = false.obs;

  set imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value].obs;
  }

  void predict() {
    try {
      _sharedController.setLoading(true);
      img.Image imageInput = img.decodeImage(image.value!.readAsBytesSync())!;
      if (imageInput.data.isNotEmpty) {
        var pred = classifier.predict(imageInput);
        category = pred;
        if (category != null) {
          prediction.value = category?.label ?? "Oops, no se predijo";
          isPredic.value = true;
        }
      }

      _sharedController.setLoading(false);
    } catch (e) {
      log('ERROR ${e.toString()}');
      prediction.value = e.toString();
    }
  }

  initIA() {
    classifier = ClassifierFloat();
  }
}

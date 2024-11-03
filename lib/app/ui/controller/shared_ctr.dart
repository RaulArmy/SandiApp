import 'package:get/get.dart';

class SharedController extends GetxController {
  static SharedController initializeController() {
    try {
      SharedController controller = Get.find<SharedController>();
      return controller;
    } catch (e) {
      SharedController controller = Get.put(SharedController());
      return controller;
    }
  }

  RxBool isLoading = false.obs;

  RxMap<String, dynamic> errorMessages = <String, dynamic>{}.obs;
  RxBool passwdObscurer = true.obs;

  void changeObscurer() {
    passwdObscurer.value = !passwdObscurer.value;
  }

  String? findErrorMessage(String key) {
    return errorMessages.containsKey(key) ? errorMessages[key] : null;
  }

  void setErrorMessage(String key, String? error) {
    (errorMessages.containsKey(key))
        ? errorMessages.update(key, (value) => error)
        : errorMessages.addAll({key: error});
  }

  void setLoading(bool isNowLoading) {
    isLoading.value = isNowLoading;
  }

  void showDialogMessage(String title, String message) {
    Get.defaultDialog(
      title: title,
      middleText: message,
    );
  }
}

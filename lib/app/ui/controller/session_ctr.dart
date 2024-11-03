import 'package:get/get.dart';
import 'package:sandiapp/app/ui/controller/shared_ctr.dart';
import 'package:sandiapp/app/ui/export_screen.dart';

import '../../../core/services/autenticacionUser.dart';

class SessionController extends GetxController {
  static SessionController initializeController() {
    try {
      SessionController controller = Get.find<SessionController>();
      return controller;
    } catch (e) {
      SessionController controller = Get.put(SessionController());
      return controller;
    }
  }

  final SharedController _sharedController =
      SharedController.initializeController();
  final AuthService _authService = AuthService();

  RxString email = "".obs;
  RxString password = "".obs;
  RxString oldpassword = "".obs;

  Future<void> logIn() async {
    _sharedController.setLoading(true);
    if (email.value.isNotEmpty && password.value.isNotEmpty) {
      final logInRequest =
          await _authService.loginWithCredentials(email.value, password.value);
      if (logInRequest) {
        reset();
        Get.toNamed(HomeScreen.routeName);
      } else {
        _sharedController.showDialogMessage(
            "Oops!", "Hubo un error al iniciar sesion");
      }
    }
    _sharedController.setLoading(false);
  }

  Future<void> newUserIn() async {
    _sharedController.setLoading(true);
    if (email.value.isNotEmpty && password.value.isNotEmpty) {
      final logInRequest =
          await _authService.createUser(email.value, password.value);
      if (logInRequest) {
        Get.toNamed(Login.routeName);
        _sharedController.showDialogMessage(
            "Genial!", "Usuario creado satisfactoriamente");
      } else {
        _sharedController.showDialogMessage(
            "Oops!", "Hubo un error al crear el usuario");
      }
    }
    _sharedController.setLoading(false);
  }

  void logOut() async {
    _sharedController.setLoading(true);

    _sharedController.setLoading(false);
  }

  void reset() {
    email = "".obs;
    password = "".obs;
    oldpassword = "".obs;
  }
}

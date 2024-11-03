import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandiapp/app/context/app_assets.dart';
import 'package:sandiapp/app/ui/controller/session_ctr.dart';
import 'package:sandiapp/app/ui/controller/shared_ctr.dart';
import 'package:sandiapp/app/ui/widget/custom/custom_buttom.dart';

import '../../../utils/input_decorations.dart';

class FromLogin extends StatelessWidget {
  FromLogin({Key? key}) : super(key: key);

  final SessionController _sessionController =
      SessionController.initializeController();
  final SharedController _sharedController =
      SharedController.initializeController();
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _inputEmail(),
          const SizedBox(height: 30),
          _inputPassword(),
          const SizedBox(height: 30),
          Obx(
            () => CustomButton(
              label:
                  _sharedController.isLoading.value ? "Ingresando" : "Ingresar",
              labelStyle: TextStyle(color: AppAssets.blackColor, fontSize: 18),
              onPressed: () async {
                await _sessionController.logIn();
                // Get.toNamed(HomeScreen.routeName);
              },
            ),
          )
        ],
      ),
    );
  }

//metodo que me permite capturar la entrada de contraseña
  Widget _inputPassword() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecorations.authInputDecoration(
        hintText: '******',
        labelText: 'Contraseña',
        prefixIcon: Icons.lock_outline,
      ),
      onChanged: (value) {
        _sessionController.password.value = value;
      },
      validator: (value) {
        return (value != null && value.length >= 6)
            ? null
            : 'La contraseña debe de ser de 6 caracteres';
      },
    );
  }

//metodo que me permite capturar la entrada de Correo
  Widget _inputEmail() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecorations.authInputDecoration(
          hintText: 'josandres123@gmail.com',
          labelText: 'Correo electrónico',
          prefixIcon: Icons.alternate_email_rounded),
      onChanged: (value) {
        _sessionController.email.value = value;
      },
      validator: (value) {
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = RegExp(pattern);

        return regExp.hasMatch(value ?? '')
            ? null
            : 'El valor ingresado no luce como un correo';
      },
    );
  }
}

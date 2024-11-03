import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandiapp/app/ui/controller/shared_ctr.dart';
import 'package:sandiapp/app/ui/export_screen.dart';
import 'package:sandiapp/app/ui/widget/custom/custom_buttom.dart';

import '../../context/app_assets.dart';
import '../../utils/input_decorations.dart';
import '../controller/session_ctr.dart';
import '../widget/custom/custom_card_container.dart';
import '../widget/others/backgroundLogin.dart';

class RegistrarScreen extends StatelessWidget {
  static const routeName = "/RegistrarScreen";
  RegistrarScreen({Key? key}) : super(key: key);
  final SessionController _sessionController =
      SessionController.initializeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroudLogin(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 220),
          CardContainer(
              child: Column(
            children: [
              const SizedBox(height: 10),
              Text('Crear cuenta',
                  style: TextStyle(color: AppAssets.blackColor, fontSize: 28)),
              const SizedBox(height: 30),
              _LoginForm(),
            ],
          )),
          const SizedBox(height: 50),
          TextButton(
              onPressed: () {
                _sessionController.reset();
                Get.toNamed(Login.routeName);
              },
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 181, 134, 63).withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())),
              child: const Text(
                'Ya tengo una cuenta',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              )),
          const SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  final SharedController _sharedController =
      SharedController.initializeController();
  final SessionController _sessionController =
      SessionController.initializeController();
  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            _entradaCorreo(),
            const SizedBox(height: 30),
            _entradaPassword(),
            const SizedBox(height: 30),
            _entradaPassword2(),
            const SizedBox(height: 30),
            Obx(
              () => CustomButton(
                labelStyle:
                    TextStyle(color: AppAssets.blackColor, fontSize: 18),
                label: _sharedController.isLoading.value
                    ? 'Registrando...'
                    : 'Registrar',
                onPressed: (_sessionController.email.isNotEmpty &&
                            _sessionController.password.isNotEmpty) &&
                        (_sessionController.password.value ==
                            _sessionController.oldpassword.value)
                    ? () async {
                        await _sessionController.newUserIn();
                      }
                    : null,
              ),
            )
          ],
        ));
  }

//metodo que me permite capturar la entrada de contraseña
  Widget _entradaPassword() {
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

  //metodo que me permite capturar la entrada de contraseña
  Widget _entradaPassword2() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecorations.authInputDecoration(
        hintText: '******',
        labelText: 'Repetir Contraseña',
        prefixIcon: Icons.lock_outline,
      ),
      onChanged: (value) {
        _sessionController.oldpassword.value = value;
      },
      validator: (value) {
        return (value == _sessionController.password.value)
            ? null
            : 'Contraseñas no coinciden';
      },
    );
  }

//metodo que me permite capturar la entrada de Correo
  Widget _entradaCorreo() {
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

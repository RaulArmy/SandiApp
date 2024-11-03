import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandiapp/app/context/app_assets.dart';
import 'package:sandiapp/app/ui/controller/session_ctr.dart';

import '../widget/custom/custom_card_container.dart';
import '../widget/custom/custom_fromLogin.dart';
import '../widget/others/backgroundLogin.dart';
import 'new_user_screem.dart';

class Login extends StatelessWidget {
  static const routeName = "/Login";
  Login({Key? key}) : super(key: key);
  final SessionController _sessionController =
      SessionController.initializeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroudLogin(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 260),
              CardContainer(
                child: Column(
                  children: [
                    Icon(
                      Icons.person_pin,
                      color: AppAssets.primaryColor,
                      size: 100,
                    ),
                    const SizedBox(height: 10),
                    Text('Usuario',
                        style: TextStyle(
                            color: AppAssets.blackColor, fontSize: 28)),
                    const SizedBox(height: 30),
                    FromLogin(),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                  onPressed: () {
                    _sessionController.reset();
                    Get.toNamed(RegistrarScreen.routeName);
                  },
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.indigo.withOpacity(0.1)),
                      shape: MaterialStateProperty.all(const StadiumBorder())),
                  child: Text(
                    'Crear una nueva cuenta',
                    style: TextStyle(
                      color: AppAssets.blackColor,
                      fontSize: 18,
                    ),
                  )),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sandiapp/app/ui/controller/controller_ia_ctr.dart';
import 'package:sandiapp/app/ui/controller/data_local_ctr.dart';
import 'package:sandiapp/app/ui/view/data_anality_screem.dart';
import 'package:sandiapp/app/ui/widget/custom/custom_buttom.dart';
import 'package:sandiapp/app/ui/widget/custom/custom_card_image.dart';
import 'package:sandiapp/app/ui/widget/custom/custom_mini_button.dart';
import 'package:sandiapp/app/ui/widget/others/shared.dart';
import 'package:sandiapp/app/ui/widget/shared/app_bar.dart';
import 'package:sandiapp/app/ui/widget/shared/app_drawer.dart';

import '../../context/app_assets.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/HomeScreen";
  HomeScreen({super.key}) {
    _iaController.initIA();
  }

  final IAController _iaController = IAController.initializeController();
  final DataLocal _dataLocal = DataLocal.initializeController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(titleP: "SandiApp"),
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 60.0,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20.0)),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      AppAssets.whiteColor,
                      AppAssets.primaryColor,
                      AppAssets.secondaryColor,
                    ]),
              ),
              child: Text("Hola, jose andres",
                  style: TextStyle(
                      color: AppAssets.blackColor,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
            ),
            Column(
              children: [
                const SizedBox(height: 10),
                Text(
                    "Bienevenido..  por favor!!, Tome o suba una foto \n Para empezar",
                    style: TextStyle(
                        color: AppAssets.blackColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal)),
                const SizedBox(height: 10),
                Obx(() =>
                    CustomImagen(_iaController.image.value?.path ?? "", size)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MiniButton(
                        text: 'Tomar foto',
                        onPressed: () async {
                          final XFile? pickedFile =
                              await _iaController.picker.pickImage(
                            // source: ImageSource.gallery,
                            source: ImageSource.camera,
                            imageQuality: 50,
                          );
                          _iaController.imageFile = pickedFile;
                          _iaController.image.value =
                              File(pickedFile?.path ?? "");
                          if (_iaController.image.value?.path.isNotEmpty ??
                              false) {
                            _iaController.predict();
                            log('Predicho');
                            log('LABER: ${_iaController.prediction.value} ');
                          } else {
                            log('Cancelado');
                          }
                        }),
                    MiniButton(
                        text: 'Subir foto',
                        onPressed: () async {
                          final XFile? pickedFile =
                              await _iaController.picker.pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 50,
                          );
                          _iaController.imageFile = pickedFile;
                          _iaController.image.value =
                              File(pickedFile?.path ?? "");
                          if (_iaController.image.value?.path.isNotEmpty ??
                              false) {
                            _iaController.predict();
                          } else {
                            log('Cancelado');
                          }
                        }),
                  ],
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Visibility(
                      visible: _iaController.isPredic.value,
                      child: CustomButton(
                        label: "Ver Analizis",
                        onPressed: () {
                          _dataLocal.loadProduct();
                          Get.toNamed(
                            DataAnalityScreem.routeName,
                          );
                        },
                      )),
                ),
                Obx(
                  () => buildCard(size, _iaController.prediction.value),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

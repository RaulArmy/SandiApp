import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandiapp/app/ui/view/conexion/home.dart';
import 'package:sandiapp/app/ui/widget/custom/custom_buttom.dart';

import '../../../context/app_assets.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        margin: const EdgeInsets.only(top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ListTile(
                  title: Text(
                    'Menu',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: AppAssets.blackColor),
                  ),
                  trailing: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.close,
                        color: AppAssets.blackColor,
                      )),
                ),
                Divider(
                  thickness: 1,
                  color: AppAssets.blackColor,
                ),
                CustomButton(
                    label: 'Conectar',
                    borderRadius: 10.0,
                    customBorder: const BorderSide(color: Colors.black),
                    backgroundColor: AppAssets.whiteColor,
                    labelStyle: const TextStyle(color: Colors.black),
                    onPressed: () {
                      Get.toNamed(ListDevice.routeName);
                    }),
                CustomButton(
                    label: 'Cerrar Sesion',
                    borderRadius: 10.0,
                    customBorder: const BorderSide(color: Colors.red),
                    backgroundColor: AppAssets.whiteColor,
                    labelStyle: const TextStyle(color: Colors.red),
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTile(IconData icon, String label, Function() onPressed) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18.0,
            color: AppAssets.blackColor),
      ),
      leading: Icon(
        icon,
        color: AppAssets.blackColor,
        size: 25.0,
      ),
      onTap: onPressed,
    );
  }
}

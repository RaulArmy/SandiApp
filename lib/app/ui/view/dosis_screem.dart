import 'package:flutter/material.dart';
import 'package:sandiapp/core/models/enfermedad.dart';

import '../../context/app_assets.dart';
import '../widget/shared/app_bar.dart';
import '../widget/shared/app_drawer.dart';

class DosisScreem extends StatelessWidget {
  const DosisScreem({super.key});
  static const routeName = "/DosisScreem";
  @override
  Widget build(BuildContext context) {
    final tratamiento =
        ModalRoute.of(context)?.settings.arguments as Tratamiento;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(titleP: "Tratatimiento"),
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side:
                    const BorderSide(color: Color.fromARGB(255, 204, 204, 204)),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      tratamiento.nombre,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("VENENO"),
                    leading: const Icon(
                      Icons.grass_sharp,
                      // size: 48,
                      color: Color.fromARGB(182, 208, 167, 1),
                    ),
                    trailing: Icon(
                      Icons.gpp_good,
                      size: 48,
                      color: AppAssets.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: size.height * 0.4,
            child: ListView.builder(
              itemCount: tratamiento.dosis.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 100,
                  width: size.width * 0.9,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 204, 204, 204)),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(tratamiento.dosis[index].aplicacion),
                          subtitle: Text("DOSIS $index"),
                          leading: const Icon(
                            Icons.energy_savings_leaf,
                            // size: 48,
                            color: Color.fromARGB(182, 208, 167, 1),
                          ),
                          trailing: Icon(
                            Icons.compost,
                            size: 48,
                            color: AppAssets.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}

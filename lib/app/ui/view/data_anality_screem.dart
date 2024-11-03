import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sandiapp/app/ui/controller/data_local_ctr.dart';
import 'package:sandiapp/app/ui/widget/others/card_enfermedad.dart';
import 'package:sandiapp/app/ui/widget/shared/app_bar.dart';

import '../../context/app_assets.dart';
import '../controller/controller_ia_ctr.dart';
import '../widget/custom/custom_mini_button.dart';
import '../widget/custom/custom_title_text.dart';
import '../widget/custom/filter_drawer.dart';
import '../widget/others/card_tratamiento.dart';
import '../widget/others/card_warning.dart';
import '../widget/shared/app_drawer.dart';

class DataAnalityScreem extends StatelessWidget {
  static const routeName = "/DataAnalityScreem";
  DataAnalityScreem({super.key});
  String dataSearch = '';

  List<String> textChips = [];
  final StreamController<String?> streamControllerFilters =
      StreamController<String>();
  final StreamController<String?> streamControllerFilters2 =
      StreamController<String>();
  List<Widget> containers = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final listStream = StreamController<List<Widget>>();
  final botonStream = StreamController<Widget>();

  final streamControl = StreamController<int>();
  final streamControl2 = StreamController<int>();

  final IAController _iaController = IAController.initializeController();
  final DataLocal _dataLocal = DataLocal.initializeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(titleP: 'Análisis'),
      endDrawer: const AppDrawer(),
      drawer: FilterDrawer(
        data: const {
          "Tratamiento": ["Tratamiento 1"],
          "Dosis": ["Dosis 1"],
          "Recomendacion": ["Recomendacion 1"],
        },
        ontapFilter: (value) {
          if (value["Tratamiento"] != null) {
            for (var i = 0; i < value["Tratamiento"]!.length; i++) {
              textChips.add(value["Tratamiento"]![i]);
            }
          }
          if (value["Dosis"] != null) {
            for (var i = 0; i < value["Dosis"]!.length; i++) {
              textChips.add(value["Dosis"]![i]);
            }
          }
          if (value["Recomendacion"] != null) {
            for (var i = 0; i < value["Recomendacion"]!.length; i++) {
              textChips.add(value["Recomendacion"]![i]);
            }
          }

          containers = [
            textChips.isEmpty
                ? const SizedBox(
                    height: 0,
                    width: 0,
                  )
                : IconButton(
                    onPressed: () {
                      containers.clear();
                      listStream.sink.add(containers);
                      textChips.clear();
                      streamControl.add(0);
                      streamControl2.add(0);
                    },
                    icon: const Icon(Icons.highlight_off_outlined))
          ];

          for (var i = 0; i < textChips.length; i++) {
            containers.add(
              Chip(label: Text(textChips[i])),
            );
          }
          listStream.sink.add(containers);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                //  color: AppAssets.primaryColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.topCenter,
                  colors: [
                    AppAssets.whiteColor,
                    AppAssets.whiteColor,
                    AppAssets.primaryColor
                  ],
                ),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MiniButton(
                        text: "Filtrar",
                        leadingIcon: Icons.filter_alt_rounded,
                        onPressed: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                      const TitleText("Pulse para filtrar")
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder<List<Widget>>(
                stream: listStream.stream,
                builder: (context, snapshot) {
                  return SizedBox(
                    height: textChips.isEmpty ? 0 : 50,
                    child: ListView.builder(
                      itemCount: containers.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return snapshot.data![index];
                      },
                    ),
                    //   ],
                    // ),
                  );
                }),
            SizedBox(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Cardenermedad(
                        dataLocal: _dataLocal, iaController: _iaController),
                  ),
                  GestureDetector(
                      child: CardTratamiento(dataLocal: _dataLocal)),
                  GestureDetector(
                      onTap: () {},
                      child: CardPrecauciones(dataLocal: _dataLocal)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

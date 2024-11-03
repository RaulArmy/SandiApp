import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../context/app_assets.dart';
import '../../controller/data_local_ctr.dart';
import '../../view/dosis_screem.dart';
import '../custom/custom_title_text.dart';

class CardTratamiento extends StatelessWidget {
  const CardTratamiento({
    Key? key,
    required DataLocal dataLocal,
  })  : _dataLocal = dataLocal,
        super(key: key);

  final DataLocal _dataLocal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      // width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _dataLocal.objData.value.tratamiento?.length,
        itemBuilder: (_, index) {
          return SizedBox(
            width: 210,
            child: GestureDetector(
              onTap: () {
                Get.toNamed(DosisScreem.routeName,
                    arguments: _dataLocal.objData.value.tratamiento?[index]);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 204, 204, 204)),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("TRATAMIENTO ${index + 1}"),
                      subtitle: const Text("estas son las dosis recomandadas"),
                      leading: Icon(
                        Icons.hive_sharp,
                        size: 48,
                        color: AppAssets.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Veneno',
                          style: TextStyle(
                              fontSize: 15, color: AppAssets.blackColor),
                        ),
                        const Icon(Icons.water_drop_outlined),
                      ],
                    ),
                    TitleText(
                        _dataLocal.objData.value.tratamiento?[index].nombre ??
                            'Sin registrp')
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

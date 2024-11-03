import 'package:flutter/material.dart';

import '../../../context/app_assets.dart';
import '../../controller/controller_ia_ctr.dart';
import '../../controller/data_local_ctr.dart';

class Cardenermedad extends StatelessWidget {
  const Cardenermedad({
    Key? key,
    required IAController iaController,
    required DataLocal dataLocal,
  })  : _iaController = iaController,
        _dataLocal = dataLocal,
        super(key: key);

  final IAController _iaController;
  final DataLocal _dataLocal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color.fromARGB(255, 204, 204, 204)),
        ),
        child: Column(
          children: [
            ListTile(
              subtitle: Text(_iaController.prediction.value),
              title: const Text("ENFERMEDAD"),
              leading: const Icon(
                Icons.coronavirus_outlined,
                size: 48,
                color: Color.fromARGB(182, 51, 107, 248),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Descripcion de la enfermedad',
                  style: TextStyle(fontSize: 18, color: AppAssets.blackColor),
                ),
                const Icon(Icons.description),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _dataLocal.objData.value.descripcion ?? "sin registro",
                style: TextStyle(fontSize: 15, color: AppAssets.blackColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

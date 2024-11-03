import 'package:flutter/material.dart';

import '../../../context/app_assets.dart';
import '../../controller/data_local_ctr.dart';

class CardPrecauciones extends StatelessWidget {
  const CardPrecauciones({
    Key? key,
    required DataLocal dataLocal,
  })  : _dataLocal = dataLocal,
        super(key: key);

  final DataLocal _dataLocal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color.fromARGB(255, 204, 204, 204)),
        ),
        child: Column(
          children: [
            const ListTile(
              title: Text("PRECAUCIONES"),
              leading: Icon(
                Icons.warning_rounded,
                size: 48,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 240,
              child: ListView.builder(
                itemCount: _dataLocal.objData.value.precauciones?.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                      height: 100,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: AppAssets.blackColor),
                        ),
                        child: ListTile(
                          title: const Text("Atencion"),
                          subtitle: Text(_dataLocal.objData.value
                                  .precauciones?[index].atencion ??
                              "sin registro"),
                          leading: const Icon(
                            Icons.cancel_outlined,
                            size: 28,
                            color: Colors.red,
                          ),
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

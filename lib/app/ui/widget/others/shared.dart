import 'dart:io';

import 'package:flutter/material.dart';

import '../../../context/app_assets.dart';
import '../custom/custom_title_text.dart';

Widget buildTitleAndCheckAction(
    String title, Function(bool? value) onChanged, bool value) {
  return Row(
    children: [
      buildTitleText(title),
      const Spacer(),
      Checkbox(
        value: value,
        onChanged: onChanged,
      ),
    ],
  );
}

Widget buildLoadingIndicator() {
  return Container(
    color: AppAssets.whiteColor,
    alignment: Alignment.center,
    child: CircularProgressIndicator(
      backgroundColor: AppAssets.whiteColor,
      color: AppAssets.primaryColor,
    ),
  );
}

Widget buildCard(Size size, label) {
  return SizedBox(
      width: size.width * 0.9,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(60),
            bottomRight: Radius.circular(60.0),
          ),
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
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              bottomRight: Radius.circular(60.0),
            ),
          ),
          color: Colors.transparent,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "PREDICCION",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppAssets.blackColor),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: AppAssets.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60.0),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    // end: Alignment.topCenter,
                    colors: [
                      AppAssets.secondaryColor,
                      AppAssets.primaryColor,
                      AppAssets.whiteColor
                    ],
                  ),
                ),
                height: 50,
                width: size.width * 0.9,
                child: Center(
                  child: buildTitleText(label),
                ),
              ),
            ],
          ),
        ),
      ));
}

Widget buildImageContent(String? path, double height) {
  return (path != null && path.isNotEmpty)
      ? Image.file(
          File(path),
          height: height,
          width: height,
          fit: BoxFit.contain,
        )
      : Container(
          width: 200.0,
          height: 200.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0)),
          child: const Icon(Icons.no_photography),
        );
}

Widget buildTitleText(String content) {
  return TitleText(
    content,
    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    textStyle: const TextStyle(
        color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
    alignment: Alignment.centerLeft,
  );
}

Widget buildContentText(String? content) {
  return TitleText(
    content ?? 'sin contenido',
    textStyle: const TextStyle(color: Colors.black, fontSize: 16.0),
    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    alignment: Alignment.centerLeft,
  );
}

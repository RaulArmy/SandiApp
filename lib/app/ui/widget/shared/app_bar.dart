import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  final String titleP;
  final Widget? leadingWidget;
  final double? fontSize;
  CustomAppBar(
      {Key? key, required this.titleP, this.leadingWidget, this.fontSize})
      : super(
          key: key,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: leadingWidget ?? Container(),
          title: Text(
            titleP,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
}

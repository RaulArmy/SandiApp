import 'dart:io';

import 'package:flutter/material.dart';

class CustomImagen extends StatelessWidget {
  final String path;
  final Size size;
  CustomImagen(this.path, this.size);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: size.width * 0.9,
          height: size.height * 0.6,
          child: path.isEmpty
              ? const Image(
                  image: AssetImage('assets/no-image.png'),
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(path),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}

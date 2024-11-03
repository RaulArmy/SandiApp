import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final EdgeInsets margin;
  final Alignment alignment;
  final TextStyle textStyle;
  final BoxConstraints constraints;
  const TitleText(this.text,
      {Key? key,
      this.alignment = Alignment.center,
      this.margin = const EdgeInsets.all(10.0),
      this.constraints = const BoxConstraints(maxWidth: 200.0),
      this.textStyle =
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      margin: margin,
      alignment: alignment,
      child: Text(
        text,
        style: textStyle,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

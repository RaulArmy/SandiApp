import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final double buttonHeight;
  final double borderRadius;
  final Color backgroundColor;
  final BorderSide customBorder;
  final EdgeInsets margin;
  final BoxConstraints? constraints;
  final TextStyle labelStyle;
  final void Function()? onPressed;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.constraints,
    this.buttonHeight = 50.0,
    this.borderRadius = 10.0,
    this.labelStyle = const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Arial'),
    this.customBorder = BorderSide.none,
    this.backgroundColor = const Color(0XFF03A851),
    this.margin = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      constraints: constraints,
      color: Colors.transparent,
      padding: EdgeInsets.zero,
      child: TextButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.resolveWith((states) => 0.0),
              backgroundColor: MaterialStateProperty.resolveWith((states) =>
                  onPressed != null ? backgroundColor : Colors.grey),
              padding: MaterialStateProperty.resolveWith((states) =>
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0)),
              minimumSize: MaterialStateProperty.resolveWith(
                  (states) => Size(buttonHeight * 2, buttonHeight)),
              shape: MaterialStateProperty.resolveWith((states) =>
                  RoundedRectangleBorder(
                      side: customBorder,
                      borderRadius: BorderRadius.circular(borderRadius)))),
          onPressed: onPressed,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              label,
              style: labelStyle,
            ),
          )),
    );
  }
}

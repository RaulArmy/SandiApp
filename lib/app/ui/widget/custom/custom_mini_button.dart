import 'package:flutter/material.dart';
import 'package:sandiapp/app/context/app_assets.dart';

class MiniButton extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String text;
  final Function() onPressed;
  const MiniButton({
    Key? key,
    this.leadingIcon,
    this.trailingIcon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.black)),
        // ignore: sort_child_properties_last
        child: Row(
          children: [
            if (leadingIcon != null) Icon(leadingIcon),
            Text(
              text,
              style: const TextStyle(fontSize: 17.0),
            ),
            if (trailingIcon != null) Icon(trailingIcon),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}

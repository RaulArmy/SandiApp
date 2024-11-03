import 'package:flutter/material.dart';

import '../../../context/app_assets.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: decoracionContainer(),
        child: child,
      ),
    );
  }

  BoxDecoration decoracionContainer() {
    return BoxDecoration(
        color: AppAssets.whiteColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppAssets.primaryColor,
            blurRadius: 25,
            offset: const Offset(0, 5),
          )
        ]);
  }
}

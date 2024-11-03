import 'package:flutter/material.dart';
import 'package:sandiapp/app/context/app_assets.dart';

class BackgroudLogin extends StatelessWidget {
  final Widget child;

  const BackgroudLogin({
    required this.child, //variable que va a contener el form email/password del usuario
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _BoxColor(),
          child,
        ],
      ),
    );
  }
}

class _BoxColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      //color: Colors.indigo[400],
      decoration: _colorBackground(),
      child: Stack(
        children: [
          Positioned(top: 50, right: -10, child: _Pelotita()),
          Positioned(bottom: -50, left: -60, child: _Pelotita()),
          Positioned(top: -50, left: -10, child: _Pelotita()),
          Positioned(bottom: -50, right: 30, child: _Pelotita()),
          Positioned(top: 100, left: 30, child: _Pelotita()),
          Positioned(top: 190, right: 30, child: _Pelotita()),
          Positioned(top: 100, right: 120, child: _Pelotita()),
        ],
      ),
    );
  }

  BoxDecoration _colorBackground() {
    return BoxDecoration(
        gradient: LinearGradient(colors: [
      AppAssets.primaryColor,
      Color.fromARGB(255, 243, 241, 252)
    ]));
  }
}

//clase que me permite crear el efecto de peloticas en el login
class _Pelotita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppAssets.whiteColor,
                AppAssets.primaryColor,
                AppAssets.tertiaryColor,
              ]),
          //color: AppAssets.primaryColor,
          //  image: const DecorationImage(
          //    image: AssetImage('assets/1.jpg'),
          //  ),
        ),
      ),
    );
  }
}

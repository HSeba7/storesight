import 'package:flutter/material.dart';
import 'package:storesight/size_config.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      "assets/images/logo.png",
      width: width(188),
      height: height(38),
    ));
  }
}

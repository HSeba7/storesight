import 'package:flutter/material.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/size_config.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var color = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator.adaptive(
              backgroundColor: color.primaryColorLight,
            ),
            SizedBox(
              height: height(15),
            ),
            CustomText(
              fontSize: width(15),
              text: "Loading..",
              fontWeight: FontWeight.w600,
              color: color.primaryColorLight,
            ),
          ],
        ),
      )),
    );
  }
}

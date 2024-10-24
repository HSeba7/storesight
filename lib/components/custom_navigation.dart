import 'package:flutter/material.dart';

Future<void> navigateTo(
    {required Widget view, required BuildContext context}) async {
  await Navigator.push(context, MaterialPageRoute(builder: (context) => view));
}

navigateReplacment({required Widget view, required BuildContext context}) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => view), (route) => false);
}

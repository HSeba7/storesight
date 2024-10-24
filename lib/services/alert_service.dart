import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/constants.dart';
import 'package:storesight/size_config.dart';

enum SnackbarType { success, warning, error }

class ErrorService {
  static String defineError(error) {
    return 'error';
  }
}

class AlertService {
  static showSnackbarAlert(String strAlert, SnackbarType type, context) {
    var color = Theme.of(context);
    Flushbar flushbar = Flushbar();
    flushbar = Flushbar(
      padding: EdgeInsets.symmetric(
        horizontal: width(16),
        vertical: height(16),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: width(16),
        vertical: height(16),
      ),
      boxShadows: [boxShadow],
      borderRadius: BorderRadius.circular(16),
      backgroundColor: color.primaryColorDark,
      titleText: CustomText(
        fontSize: width(16),
        text: type.name,
        fontWeight: FontWeight.w600,
        color: color.primaryColor,
      ),
      messageText: CustomText(
        fontSize: width(14),
        maxlines: 3,
        text: strAlert,
      ),
      icon: SvgPicture.asset("assets/icons/${type.name}.svg"),
      mainButton: GestureDetector(
        onTap: () {
          flushbar.dismiss(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width(16),
          ),
          child: SvgPicture.asset("assets/icons/exit.svg"),
        ),
      ),
    );
    flushbar.show(context);
  }
}

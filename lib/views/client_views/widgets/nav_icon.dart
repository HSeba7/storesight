import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/size_config.dart';

class NavIcon extends StatelessWidget {
  const NavIcon({
    super.key,
    required this.icon,
    required this.label,
    this.leading = false,
  });

  final String icon, label;
  final bool leading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading)
          SizedBox(
            width: width(28),
          ),
        SvgPicture.asset(
          icon,
          width: width(25),
          height: height(25),
        ),
        SizedBox(
          width: width(7.5),
        ),
        CustomText(
          fontSize: width(14),
          text: label,
          fontWeight: FontWeight.w600,
        ),
        if (!leading)
          SizedBox(
            width: width(28),
          ),
      ],
    );
  }
}

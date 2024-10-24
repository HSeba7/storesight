import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/size_config.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({
    super.key,
    this.onBack,
    this.color,
  });

  final Function()? onBack;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBack ??
          () {
            Navigator.pop(context);
          },
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/back.svg",
            color: color,
          ),
          SizedBox(
            width: width(5),
          ),
          CustomText(
            fontSize: width(16),
            text: "Wróć",
            color: color,
          ),
        ],
      ),
    );
  }
}

class CircleBackWidget extends StatelessWidget {
  const CircleBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.primaryColor,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          "assets/icons/back.svg",
          width: width(24),
          height: height(24),
          color: color.primaryColorLight,
        ),
      ),
    );
  }
}

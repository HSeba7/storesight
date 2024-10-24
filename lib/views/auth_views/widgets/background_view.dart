import 'package:flutter/material.dart';
import 'package:storesight/size_config.dart';

class BackgroundView extends StatelessWidget {
  const BackgroundView({
    super.key,
    required this.arcHeight,
  });

  final double arcHeight;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Stack(
      children: [
        Container(
          color: color.colorScheme.secondary,
          width: double.infinity,
          height: SizeConfig.screenHeight,
        ),
        Container(
          width: double.infinity,
          height: height(arcHeight),
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.elliptical(200, 80)),
            color: color.primaryColor,
          ),
        ),
      ],
    );
  }
}

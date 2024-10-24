import 'package:flutter/material.dart';
import 'package:storesight/constants.dart';
import 'package:storesight/size_config.dart';

class CustomModelSheet extends StatelessWidget {
  const CustomModelSheet({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: color.colorScheme.secondary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 65,
            height: 3,
            decoration: BoxDecoration(
              color: const Color(0xFF707070),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          SizedBox(
            height: height(30),
          ),
          child,
        ],
      ),
    );
  }
}

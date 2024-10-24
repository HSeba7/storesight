import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return Align(
      alignment: AlignmentDirectional.topStart,
      child: GestureDetector(
        onTap: onTap ??
            () {
              Navigator.pop(context);
            },
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color.highlightColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back_rounded,
            color: color.focusColor,
            size: 16,
          ),
        ),
      ),
    );
  }
}

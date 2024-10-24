import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.color,
    required this.fontSize,
    required this.text,
    this.maxlines,
    this.textDecoration,
    this.height,
    this.fontWeight,
    this.align,
    this.textOverflow = TextOverflow.ellipsis,
  });

  final String text;
  final double fontSize;
  final Color? color;
  final TextAlign? align;
  final TextDecoration? textDecoration;
  final FontWeight? fontWeight;
  final double? height;
  final int? maxlines;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxlines,
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? Theme.of(context).primaryColorLight,
        height: height,
        decoration: textDecoration,
        decorationColor: color ?? Theme.of(context).primaryColorLight,
        fontWeight: fontWeight,
        overflow: textOverflow,
      ),
    );
  }
}

class PriceTag extends StatelessWidget {
  const PriceTag(
      {super.key,
      required this.price,
      required this.fontSize,
      this.textDecoration,
      this.fontColor});

  final String price;
  final double fontSize;
  final Color? fontColor;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Align(
      alignment: Alignment.center,
      child: CustomText(
        fontSize: fontSize,
        text: "$price zł",
        textOverflow: TextOverflow.ellipsis,
        textDecoration: textDecoration,
        align: TextAlign.start,
        fontWeight: FontWeight.w700,
        color: fontColor ?? color.primaryColorLight,
      ),
    );
  }
}

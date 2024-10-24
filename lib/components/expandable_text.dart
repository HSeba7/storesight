import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int limit;
  final Color? color;
  final double? fontSize;

  const ExpandableText(
      {Key? key,
      required this.text,
      required this.limit,
      this.color,
      this.fontSize})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool showMore = true;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: showMore && widget.text.length > widget.limit
              ? widget.text.substring(0, widget.limit)
              : widget.text,
          style: GoogleFonts.poppins(
              color: widget.color, fontSize: widget.fontSize),
        ),
        TextSpan(
            text: showMore ? '... read More' : " show Less",
            style: TextStyle(
              color: color.primaryColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => setState(() {
                    showMore = !showMore;
                  })),
      ]),
    );
  }
}

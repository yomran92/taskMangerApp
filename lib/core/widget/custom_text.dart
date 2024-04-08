import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final int? numOfLine;

  final AlignmentGeometry alignmentGeometry;
  final double paddingVertical;
  final double paddingHorizantal;

  const CustomText(
      {required this.text,
      required this.style,
      this.alignmentGeometry = Alignment.centerLeft,
      this.paddingVertical = 0,
      this.paddingHorizantal = 0,
      this.textAlign,
      this.numOfLine,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: paddingVertical, horizontal: paddingHorizantal),
        alignment: alignmentGeometry,
        child: Text(
          text,
          textAlign: textAlign??TextAlign.start,
          strutStyle: StrutStyle(
              height: 1.2,
              forceStrutHeight: true,
              fontSize: style.fontSize,
              fontFamily: style.fontFamily,
              fontWeight: style.fontWeight,
              fontStyle: FontStyle.normal),
          style: this.style,
          softWrap: true,
          overflow: TextOverflow.clip,
          maxLines: this.numOfLine,
          // overflow: TextOverflow.ellipsis,
        ));
  }
}

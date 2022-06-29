import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:x_bank/configs/font_config.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';

class NormalTextView extends StatelessWidget {
  final String? content;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final TextAlign? textAlign;
  final AlignmentGeometry? alignment;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextDecoration? decoration;
  final TextBaseline? textBaseline;

  NormalTextView(
      {Key? key,
      required this.content,
      this.color,
      this.margin,
      this.fontSize,
      this.textAlign,
      this.alignment,
      this.maxLines = 1,
      this.textOverflow = TextOverflow.ellipsis,
      this.textStyle,
      this.fontWeight,
      this.fontFamily,
      this.decoration = TextDecoration.none,
      this.textBaseline = TextBaseline.alphabetic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double theFontSize = fontSize ?? Dimens.font_normal;
    Color theColor = color ?? SColors.text_content;

    TextStyle theTextStyle = textStyle ??
        TextStyle(
            fontSize: theFontSize,
            color: theColor,
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            decoration: decoration,
            textBaseline: textBaseline,
            height: FontConfig.font_size_scale);
    Widget contentView = Text(
      content ?? "",
      maxLines: maxLines,
      overflow: textOverflow,
      textAlign: textAlign,
      style: theTextStyle,
    );
    return Container(
      margin: margin,
      alignment: alignment,
      child: contentView,
    );
  }
}

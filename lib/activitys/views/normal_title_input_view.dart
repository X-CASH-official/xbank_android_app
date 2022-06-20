import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:framework/base/base_callback_function.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_input_view.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';

class NormalTitleInputView extends StatelessWidget {
  final String? title;
  final String? defaultContentText;
  final EdgeInsetsGeometry? padding;
  final Color? titleColor;
  final double? titleFontSize;
  final double? fontSize;
  final Color? textColor;
  final String? hintText;
  final Color? hintColor;
  final int? maxLength;
  final Color background;
  final double? radius;
  final Color cursorColor;
  final double? cursorWidth;
  final VoidStringCallback? onTextChange;
  final VoidCallback? onEditingComplete;
  final Widget? suffixView;
  final bool obscureText;
  final Pattern pattern;

  NormalTitleInputView({
    Key? key,
    this.title,
    this.defaultContentText,
    this.padding,
    this.titleColor,
    this.titleFontSize,
    this.fontSize,
    this.textColor,
    this.hintText,
    this.hintColor,
    this.maxLength,
    this.background = Colors.transparent,
    this.radius,
    this.cursorColor = SColors.text_content,
    this.cursorWidth,
    this.onTextChange,
    this.onEditingComplete,
    this.suffixView,
    this.obscureText = false,
    this.pattern = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color theTitleColor = titleColor ?? SColors.text_title;
    double theTitleFontSize = titleFontSize ?? Dimens.font_normal;
    Color theTextColor = textColor ?? SColors.text_content;
    double theFontSize = fontSize ?? Dimens.font_normal;
    Color theHintColor = hintColor ?? SColors.text_hint;
    NormalInputView normalInputView = NormalInputView(
      disposeTextEditingController: false,
      text: defaultContentText,
      textColor: theTextColor,
      fontSize: theFontSize,
      inputFormatters: pattern != ""
          ? [
              FilteringTextInputFormatter.allow(pattern),
              LengthLimitingTextInputFormatter(maxLength),
            ]
          : [
              LengthLimitingTextInputFormatter(maxLength),
            ],
      showBorder: true,
      hintText: hintText,
      hintColor: theHintColor,
      onTextChange: onTextChange,
      cursorWidth: cursorWidth,
      cursorColor: cursorColor,
      contentPadding: EdgeInsets.symmetric(vertical: Dimens.margin_narrow),
      onEditingComplete: onEditingComplete,
      suffixView: suffixView,
      obscureText: obscureText,
    );

    Widget contentView = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DimenBoxs.vBoxSuperNarrow,
        NormalTextView(
          content: title,
          fontSize: theTitleFontSize,
          color: theTitleColor,
        ),
        DimenBoxs.vBoxNarrow,
        normalInputView,
        DimenBoxs.vBoxNarrow,
      ],
    );
    return Container(
      padding: padding,
      child: contentView,
    );
  }
}

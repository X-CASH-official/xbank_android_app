import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:framework/base/base_callback_function.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_input_view.dart';

class NormalLoadingInputView extends StatelessWidget {
  final String? defaultContentText;
  final EdgeInsetsGeometry? padding;
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
  final bool showLoading;
  final int? maxLines;
  final bool enable;
  final TextAlign? textAlign;
  final TextEditingController? textEditingController;

  NormalLoadingInputView(
      {Key? key,
      this.defaultContentText,
      this.padding,
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
      this.showLoading = false,
      this.maxLines = 1,
      this.enable = true,
      this.textAlign,
      this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color theTextColor = textColor ?? SColors.text_content;
    double theFontSize = fontSize ?? Dimens.font_normal;
    Color theHintColor = hintColor ?? SColors.text_hint;
    NormalInputView normalInputView = NormalInputView(
      textEditingController: textEditingController,
      enable: enable,
      disposeTextEditingController: false,
      text: defaultContentText,
      textColor: theTextColor,
      fontSize: theFontSize,
      maxLines: maxLines,
      textAlign: textAlign,
      showDisabledBorder: false,
      inputFormatters: pattern != ""
          ? [
              FilteringTextInputFormatter.allow(pattern),
              LengthLimitingTextInputFormatter(maxLength),
            ]
          : [
              LengthLimitingTextInputFormatter(maxLength),
            ],
      showBorder: false,
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

    Widget contentView = Row(
      children: [
        Expanded(child: normalInputView),
        showLoading
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: Dimens.margin_narrow),
                child: CupertinoActivityIndicator(),
                width: Dimens.margin_normal,
                height: Dimens.margin_normal,
              )
            : Container()
      ],
    );
    return Container(
      padding: padding,
      child: contentView,
      decoration: BoxDecoration(
        border:
            Border.all(color: SColors.text_content, width: Dimens.line_narrow),
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.radius_normal),
        ),
      ),
    );
  }
}

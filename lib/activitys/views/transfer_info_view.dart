import 'package:flutter/material.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';

class NormalTransferView extends StatelessWidget {
  final String? title;
  final String? content;
  final Color? titleColor;
  final Color? contentColor;
  final double? titleFontSize;
  final double? contentFontSize;
  final EdgeInsetsGeometry? padding;

  NormalTransferView(
      {Key? key,
      this.title,
      this.content,
      this.titleColor,
      this.contentColor,
      this.titleFontSize,
      this.contentFontSize,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color theTitleColor = titleColor ?? SColors.text_title;
    Color theContentColor = contentColor ?? SColors.text_content;
    double theTitleFontSize = titleFontSize ?? Dimens.font_normal;
    double theContentFontSize = contentFontSize ?? Dimens.font_normal;
    Widget contentView = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalTextView(
          content: title,
          fontSize: theTitleFontSize,
          color: theTitleColor,
        ),
        DimenBoxs.hBoxNormal,
        Expanded(
          child: NormalTextView(
            content: content,
            fontSize: theContentFontSize,
            maxLines: AppConfig.maxLines,
            color: theContentColor,
          ),
        )
      ],
    );
    return Container(
      padding: padding,
      child: contentView,
    );
  }
}

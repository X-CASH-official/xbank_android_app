import 'package:flutter/material.dart';
import 'package:x_bank/resources/dimens.dart';

import 'normal/normal_text_view.dart';

class BottomTabView extends StatelessWidget {
  final Widget imageIcon;
  final String? title;
  final double? titleSize;
  final double space;
  final Color color;
  final VoidCallback? onClick;

  BottomTabView(
      {Key? key,
      required this.imageIcon,
      this.title,
      this.titleSize,
      this.space = 0,
      this.color = Colors.white,
      this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double theTitleSize = titleSize ?? Dimens.font_normal;
    Widget contentView = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: space),
        imageIcon,
        SizedBox(height: space),
        NormalTextView(content: title, fontSize: theTitleSize, color: color),
        SizedBox(height: space),
      ],
    );
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: contentView,
        onTap: () {
          onClick?.call();
        },
      ),
    );
  }
}

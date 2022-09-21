import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/base/base_callback_function.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_icon_view.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';

class SwitchCoinItemView extends StatelessWidget {
  String? title;
  bool isSelect;
  VoidCallback? onClick;

  SwitchCoinItemView(
      {Key? key, this.title, this.isSelect = false, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildContentView();
  }

  Widget _buildContentView() {
    Widget contentView = Row(
      children: [
        Expanded(
          child: NormalTextView(
              content: title,
              color: SColors.text_title,
              fontSize: Dimens.font_broad),
          flex: 1,
        ),
        NormalIconView(
          iconData: Icons.album_outlined,
          fontSize: Dimens.font_broad,
          color: isSelect ? SColors.primary : SColors.text_hint,
          icon: -1,
        ),
        NormalIconView(
          iconData: Icons.arrow_forward_ios_sharp,
          fontSize: Dimens.font_broad,
          color: SColors.text_hint,
          icon: -1,
        ),
      ],
    );
    return Container(
      child: GestureDetector(
          child: contentView,
          onTap: onClick,
          behavior: HitTestBehavior.translucent),
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.margin_normal, vertical: Dimens.margin_normal),
      decoration: BoxDecoration(
        color: SColors.main_help,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.radius_normal),
        ),
      ),
    );
  }
}

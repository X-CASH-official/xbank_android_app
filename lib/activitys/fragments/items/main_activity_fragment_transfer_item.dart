import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/models/transfer.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/utils/string_util.dart';
import 'package:x_bank/widgets/normal/normal_icon_view.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';

class MainActivityFragmentTransferItem extends StatelessWidget {
  final Transfer data;
  final VoidCallback? onClick;
  final bool isTop;
  final String? source;

  MainActivityFragmentTransferItem(
      {Key? key,
      required this.data,
      this.onClick,
      this.isTop = false,
      this.source})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: _buildContentView(),
        margin: EdgeInsets.symmetric(vertical: Dimens.margin_super_narrow),
        padding: EdgeInsets.all(Dimens.margin_normal),
        decoration: BoxDecoration(
          color: SColors.main_help,
          borderRadius: BorderRadius.all(
            Radius.circular(Dimens.radius_normal),
          ),
        ),
      ),
      onTap: onClick,
    );
  }

  Widget _buildContentView() {
    String time = StringUtil.convertUtcTime(data.created_at ?? "0");
    return Row(
      children: [
        Expanded(child: _buildDetailsView()),
        DimenBoxs.hBoxNormal,
        NormalTextView(
          color: SColors.text_content,
          fontSize: Dimens.font_narrow,
          content: time,
        ),
        DimenBoxs.hBoxSuperNarrow,
        NormalIconView(
          icon: -1,
          iconData: Icons.arrow_forward_ios_rounded,
          fontSize: Dimens.font_more_narrow,
          color: SColors.text_hint,
        ),
      ],
    );
  }

  Widget _buildDetailsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalTextView(
          color: data.type == "in" ? SColors.transfer_in : SColors.transfer_out,
          fontSize: Dimens.font_normal,
          content: ((data.atomic_amount ?? 0) / 1000000).toString() +
              " " +
              (data.currency ?? ""),
        ),
        DimenBoxs.vBoxSuperNarrow,
        NormalTextView(
          color: data.type == "in" ? SColors.transfer_in : SColors.transfer_out,
          fontSize: Dimens.font_normal,
          content: (data.amount_usd ?? 0).toStringAsFixed(6) +
              " " +
              AppConfig.appS.usd_unit_text,
        ),
      ],
    );
  }
}

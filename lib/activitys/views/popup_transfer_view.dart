import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/base/base_callback_function.dart';
import 'package:x_bank/activitys/views/transfer_info_view.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/models/transfer.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_button_view.dart';

class PopupTransferView extends StatelessWidget {
  Transfer transfer;
  VoidCallback? onSubmitClick;

  PopupTransferView({Key? key, required this.transfer, this.onSubmitClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildContentView(),
      ],
    );
  }

  Widget _buildContentView() {
    Widget contentView = Column(mainAxisSize: MainAxisSize.min, children: [
      DimenBoxs.vBoxSuperBroad,
      NormalTransferView(
        title: AppConfig.appS.transfer_details_activity_transfer_tx_hash_text,
        content: transfer.tx_hash,
      ),
      DimenBoxs.vBoxNormal,
      NormalTransferView(
        title: AppConfig
            .appS.transfer_details_activity_transfer_recipient_address_text,
        content: transfer.recipient_address,
      ),
      DimenBoxs.vBoxNormal,
      NormalTransferView(
          title: AppConfig.appS.transfer_details_activity_transfer_amount_text,
          content: ((transfer.atomic_amount ?? 0) / 1000000).toString()),
      DimenBoxs.vBoxNormal,
      NormalTransferView(
          title: AppConfig.appS.transfer_details_activity_transfer_fee_text,
          content: ((transfer.atomic_fee ?? 0) / 1000000).toString()),
      DimenBoxs.vBoxNormal,
      NormalTransferView(
        title:
            AppConfig.appS.transfer_details_activity_transfer_payment_id_text,
        content: transfer.payment_id,
      ),
      DimenBoxs.vBoxSuperBroad,
      Container(
        child: NormalButtonView(
          text: AppConfig.appS.submit,
          showStroke: false,
          color: SColors.primary,
          radius: Dimens.radius_narrow,
          fontSize: Dimens.font_narrow,
          textColor: SColors.main_help,
          height: Dimens.button_height_narrow,
          onClick: onSubmitClick,
        ),
      ),
      DimenBoxs.vBoxSuperBroad,
    ]);
    return Container(
      child: contentView,
      decoration: BoxDecoration(
        color: SColors.main_help,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.radius_normal),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: Dimens.margin_normal),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:framework/base/base_activity.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/activitys/views/transfer_info_view.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/controllers/transfer_details_activity_controller.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/utils/string_util.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';
import 'package:x_bank/widgets/normal/normal_toolbar_view.dart';

import 'new_base_activity.dart';

class TransferDetailsActivity extends NewBaseActivity {
  TransferDetailsActivity(bundle) : super(bundle: bundle);

  @override
  BaseActivityState getState() => TransferDetailsActivityState();
}

class TransferDetailsActivityState
    extends NewBaseActivityState<TransferDetailsActivity> {
  TransferDetailsActivityController _controller =
      TransferDetailsActivityController();

  @override
  BaseController initController() {
    return _controller;
  }

  @override
  Widget buildViews(BuildContext context) {
    return NormalToolbarView(
      showBack: true,
      showLeftTitle: true,
      backgroundColor: SColors.background,
      title: AppConfig.appS.transfer_details_activity_title,
      onBackClick: () {
        finish();
      },
      // actions: _buildActionsViews(),
      body: _buildBodyView(),
    );
  }

  Widget _buildBodyView() {
    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NormalTextView(
                content:
                    AppConfig.appS.transfer_details_activity_transfer_info_text,
                color: SColors.text_title,
                margin: EdgeInsets.all(Dimens.margin_normal),
                fontSize: Dimens.font_broad),
            DimenBoxs.vBoxNarrow,
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.margin_normal),
              child: _buildContentView(),
            )
          ]),
    );
  }

  Widget _buildContentView() {
    Widget contentView = _controller.transfer != null
        ? Column(mainAxisSize: MainAxisSize.min, children: [
            DimenBoxs.vBoxNormal,
            NormalTransferView(
              title: AppConfig
                  .appS.transfer_details_activity_transfer_tx_type_text,
              content: _controller.transfer!.type,
            ),
            DimenBoxs.vBoxNormal,
            NormalTransferView(
              title: AppConfig
                  .appS.transfer_details_activity_transfer_tx_hash_text,
              content: _controller.transfer!.tx_hash,
            ),
            DimenBoxs.vBoxNormal,
            // NormalTransferView(
            //   title:
            //       AppConfig.appS.transfer_details_activity_transfer_tx_key_text,
            //   content: _controller.transfer!.tx_key,
            // ),
            // DimenBoxs.vBoxNormal,
            NormalTransferView(
              title: AppConfig.appS
                  .transfer_details_activity_transfer_recipient_address_text,
              content: _controller.transfer!.recipient_address,
            ),
            // DimenBoxs.vBoxNormal,
            // NormalTransferView(
            //   title: AppConfig
            //       .appS.transfer_details_activity_transfer_block_height_text,
            //   content: _controller.transfer!.block_height.toString(),
            // ),
            DimenBoxs.vBoxNormal,
            NormalTransferView(
                title: AppConfig
                    .appS.transfer_details_activity_transfer_amount_text,
                content: ((_controller.transfer!.atomic_amount ?? 0) / 1000000)
                    .toString()),
            DimenBoxs.vBoxNormal,
            NormalTransferView(
                title:
                    AppConfig.appS.transfer_details_activity_transfer_fee_text,
                content: ((_controller.transfer!.atomic_fee ?? 0) / 1000000)
                    .toString()),
            DimenBoxs.vBoxNormal,
            NormalTransferView(
                title: AppConfig
                    .appS.transfer_details_activity_transfer_amount_usd_text,
                content: _controller.transfer!.amount_usd.toString()),
            DimenBoxs.vBoxNormal,
            NormalTransferView(
                title: AppConfig
                    .appS.transfer_details_activity_transfer_status_text,
                content: _controller.transfer!.status.toString()),
            DimenBoxs.vBoxNormal,
            NormalTransferView(
              title: AppConfig
                  .appS.transfer_details_activity_transfer_payment_id_text,
              content: _controller.transfer!.payment_id,
            ),
            DimenBoxs.vBoxNormal,
            NormalTransferView(
              title: AppConfig
                  .appS.transfer_details_activity_transfer_payment_time_text,
              content: StringUtil.convertUtcTime(
                  _controller.transfer!.created_at ?? "0"),
            ),
            DimenBoxs.vBoxNormal,
          ])
        : Container();
    return Container(
        child: contentView,
        decoration: BoxDecoration(
          color: SColors.main_help,
          borderRadius: BorderRadius.all(
            Radius.circular(Dimens.radius_normal),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal:Dimens.margin_normal),
      );
  }
}

import 'package:flutter/material.dart';
import 'package:framework/base/base_activity.dart';
import 'package:framework/base/base_fragment.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/controllers/fragments/main_activity_fragment_deposit_controller.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/utils/view_util.dart';
import 'package:x_bank/widgets/normal/normal_button_view.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';

import 'new_base_fragment.dart';

class MainActivityFragmentDeposit extends NewBaseFragment {
  MainActivityFragmentDeposit(BaseActivityState baseActivityState,
      {Key? key, Bundle? bundle})
      : super(baseActivityState, key: key, bundle: bundle);

  @override
  BaseFragmentState getState() => MainActivityFragmentDepositState();
}

class MainActivityFragmentDepositState
    extends NewBaseFragmentState<MainActivityFragmentDeposit> {
  MainActivityFragmentDepositController _controller =
      MainActivityFragmentDepositController();

  @override
  BaseController initController() {
    return _controller;
  }

  @override
  Widget buildViews(BuildContext context) {
    Widget contentView = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalTextView(
            content: AppConfig.appS.main_activity_tab_deposit,
            color: SColors.text_title,
            margin: EdgeInsets.all(Dimens.margin_normal),
            fontSize: Dimens.font_max_broad),
        DimenBoxs.vBoxSuperBroad,
        Expanded(
          child: SingleChildScrollView(
            controller: _controller.scrollController,
            child: _controller.address != null ? _buildBodyView() : Container(),
          ),
        )
      ],
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: SColors.background,
      body: SafeArea(
        top: true,
        child: contentView,
      ),
    );
  }

  Widget _buildBodyView() {
    Widget contentView = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAddressView(),
        DimenBoxs.vBoxSuperBroad,
        NormalButtonView(
          text: AppConfig.appS.main_activity_fragment_deposit_copy_text,
          showStroke: false,
          color: SColors.primary,
          radius: Dimens.radius_narrow,
          fontSize: Dimens.font_narrow,
          textColor: SColors.main_help,
          height: Dimens.button_height_normal,
          onClick: () {
            _controller.copyAddressToClipboard();
          },
        ),
        DimenBoxs.vBoxSuperBroad,
        NormalTextView(
            content: AppConfig.appS.main_activity_fragment_deposit_scan_tips,
            color: SColors.text_title,
            margin: EdgeInsets.all(Dimens.margin_narrow),
            fontSize: Dimens.font_narrow),
        ViewUtil.getDefaultLine(),
        DimenBoxs.vBoxSuperNarrow,
        QrImage(
          data: _controller.address!,
          size: MediaQuery.of(context).size.width * 0.4,
        ),
      ],
    );
    return Container(
      child: contentView,
      margin: EdgeInsets.all(Dimens.margin_normal),
    );
  }

  Widget _buildAddressView() {
    Widget contentView = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalTextView(
            margin: EdgeInsets.symmetric(
                vertical: Dimens.margin_narrow,
                horizontal: Dimens.margin_normal),
            content:
                AppConfig.appS.main_activity_fragment_deposit_address_title,
            color: SColors.text_title,
            fontWeight: FontWeight.w600,
            maxLines: AppConfig.maxLines,
            fontSize: Dimens.font_normal),
        NormalTextView(
            margin: EdgeInsets.symmetric(
                vertical: Dimens.margin_narrow,
                horizontal: Dimens.margin_normal),
            content: AppConfig.appS.main_activity_fragment_deposit_address_tips,
            color: SColors.text_content,
            maxLines: AppConfig.maxLines,
            fontSize: Dimens.font_normal),
        ViewUtil.getDefaultLine(),
        NormalTextView(
            margin: EdgeInsets.all(Dimens.margin_normal),
            content: _controller.address,
            color: SColors.text_content,
            fontWeight: FontWeight.w600,
            maxLines: AppConfig.maxLines,
            fontSize: Dimens.font_normal),
      ],
    );
    return Container(
        child: contentView,
        decoration: BoxDecoration(
          color: SColors.main_help,
          borderRadius: BorderRadius.all(
            Radius.circular(Dimens.radius_normal),
          ),
        ));
  }
}

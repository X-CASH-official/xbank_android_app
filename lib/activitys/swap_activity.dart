import 'package:flutter/material.dart';
import 'package:framework/base/base_activity.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/activitys/views/normal_loading_input_view.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/assets_config.dart';
import 'package:x_bank/controllers/swap_activity_controller.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/utils/coin_symbol_util.dart';
import 'package:x_bank/widgets/normal/normal_button_view.dart';
import 'package:x_bank/widgets/normal/normal_icon_view.dart';
import 'package:x_bank/widgets/normal/normal_image_view.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';
import 'package:x_bank/widgets/normal/normal_toolbar_view.dart';

import 'new_base_activity.dart';

class SwapActivity extends NewBaseActivity {
  SwapActivity(bundle) : super(bundle: bundle);

  @override
  BaseActivityState getState() => SwapActivityState();
}

class SwapActivityState extends NewBaseActivityState<SwapActivity> {
  SwapActivityController _controller = SwapActivityController();

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
      title: AppConfig.appS.swap_activity_title,
      onBackClick: () {
        finish();
      },
      body: _buildBodyView(),
    );
  }

  Widget _buildBodyView() {
    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DimenBoxs.vBoxSuperBroad,
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.margin_normal),
              child: _buildContentView(),
            )
          ]),
    );
  }

  Widget _buildContentView() {
    Widget contentView = Column(mainAxisSize: MainAxisSize.min, children: [
      _buildTopView(),
      DimenBoxs.vBoxBroad,
      NormalLoadingInputView(
        textEditingController: _controller.textEditingTopController,
        pattern: RegExp("[0-9.]"),
        fontSize: Dimens.font_normal,
        padding: EdgeInsets.only(left: Dimens.margin_narrow),
        showLoading: false,
        onTextChange: (value) {
          _controller.updateSwapAmount(value);
        },
        suffixView: NormalTextView(
            margin: EdgeInsets.symmetric(horizontal: Dimens.margin_narrow),
            content: _controller.getTopCoinSymbol(),
            color: SColors.text_content,
            fontSize: Dimens.font_normal),
      ),
      Stack(
        children: [
          Align(
            child: NormalIconView(
              iconData: Icons.arrow_downward_rounded,
              fontSize: Dimens.font_super_broad,
              padding: EdgeInsets.all(Dimens.margin_normal),
              color: SColors.text_content,
              icon: -1,
            ),
            alignment: Alignment.center,
          ),
          Align(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _controller.updateTargetCoinSymbol();
              },
              child: NormalIconView(
                iconData: Icons.all_inclusive_rounded,
                fontSize: Dimens.font_super_broad,
                padding: EdgeInsets.all(Dimens.margin_normal),
                color: SColors.primary,
                icon: -1,
              ),
            ),
            alignment: Alignment.centerRight,
          ),
        ],
      ),
      NormalLoadingInputView(
        textEditingController: _controller.textEditingBottomController,
        enable: false,
        pattern: RegExp("[0-9.]"),
        fontSize: Dimens.font_normal,
        padding: EdgeInsets.only(left: Dimens.margin_narrow),
        showLoading: false,
        onTextChange: (value) {},
        suffixView: NormalTextView(
            margin: EdgeInsets.symmetric(horizontal: Dimens.margin_narrow),
            content: _controller.getBottomCoinSymbol(),
            color: SColors.text_content,
            fontSize: Dimens.font_normal),
      ),
      DimenBoxs.vBoxSuperBroad,
      NormalButtonView(
        width: Dimens.button_width_normal,
        text: AppConfig.appS.swap_activity_button_text,
        showStroke: false,
        color: SColors.primary,
        radius: Dimens.radius_narrow,
        fontSize: Dimens.font_narrow,
        textColor: SColors.main_help,
        height: Dimens.button_height_normal,
        onClick: () {
          _controller.doSwap();
        },
      ),
      DimenBoxs.vBoxBroad,
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

  Widget _buildTopView() {
    Widget contentView = Row(
      children: [
        NormalImageView(
          margin: EdgeInsets.all(Dimens.margin_normal),
          width: Dimens.font_super_broad * 4,
          assetUrl: AssetImageConfig.xcash_logo,
        ),
        DimenBoxs.hBoxNormal,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NormalTextView(
                  content: _controller
                          .getAmount(CoinSymbolUtil.coin_symbol_xcash)
                          .toString() +
                      " " +
                      CoinSymbolUtil.coin_symbol_xcash,
                  color: SColors.text_title,
                  fontSize: Dimens.font_broad),
              DimenBoxs.vBoxNarrow,
              NormalTextView(
                  content: _controller
                          .getAmount(CoinSymbolUtil.coin_symbol_wxcash)
                          .toString() +
                      " " +
                      CoinSymbolUtil.coin_symbol_wxcash,
                  color: SColors.text_title,
                  fontSize: Dimens.font_broad),
              DimenBoxs.vBoxSuperNarrow,
            ],
          ),
          flex: 1,
        )
      ],
    );
    return Container(
      child: contentView,
      padding: EdgeInsets.all(Dimens.margin_normal),
      decoration: BoxDecoration(
        color: SColors.main_help,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.radius_normal),
        ),
      ),
    );
  }
}

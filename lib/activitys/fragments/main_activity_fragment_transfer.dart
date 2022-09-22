import 'package:flutter/material.dart';
import 'package:framework/base/base_activity.dart';
import 'package:framework/base/base_fragment.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/activitys/views/normal_loading_input_view.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/assets_config.dart';
import 'package:x_bank/controllers/fragments/main_activity_fragment_transfer_controller.dart';
import 'package:x_bank/models/transfer.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/utils/coin_symbol_util.dart';
import 'package:x_bank/widgets/normal/normal_button_view.dart';
import 'package:x_bank/widgets/normal/normal_icon_view.dart';
import 'package:x_bank/widgets/normal/normal_image_view.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';
import 'package:x_bank/widgets/pull_refresh_view.dart';

import 'items/main_activity_fragment_transfer_item.dart';
import 'new_base_fragment.dart';

class MainActivityFragmentTransfer extends NewBaseFragment {
  MainActivityFragmentTransfer(BaseActivityState baseActivityState,
      {Key? key, Bundle? bundle})
      : super(baseActivityState, key: key, bundle: bundle);

  @override
  BaseFragmentState getState() => MainActivityFragmentTransferState();
}

class MainActivityFragmentTransferState
    extends NewBaseFragmentState<MainActivityFragmentTransfer>
    with TickerProviderStateMixin {
  MainActivityFragmentTransferController _controller =
      MainActivityFragmentTransferController();

  @override
  BaseController initController() {
    _controller.animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    return _controller;
  }

  @override
  Widget buildViews(BuildContext context) {
    Widget contentView = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _controller.isTransfer
            ? GestureDetector(
                onTap: () {
                  _controller.closeNewTransfer();
                },
                behavior: HitTestBehavior.translucent,
                child: Row(
                  children: [
                    NormalIconView(
                      iconData: Icons.arrow_back_ios_sharp,
                      fontSize: Dimens.font_broad,
                      padding: EdgeInsets.all(Dimens.margin_normal),
                      color: SColors.primary,
                      icon: -1,
                    ),
                    NormalTextView(
                        content: AppConfig.appS.back,
                        color: SColors.primary,
                        fontSize: Dimens.font_broad),
                  ],
                ),
              )
            : Container(),
        NormalTextView(
            content: AppConfig.appS.main_activity_tab_transfer,
            color: SColors.text_title,
            margin: EdgeInsets.all(Dimens.margin_normal),
            fontSize: Dimens.font_max_broad),
        DimenBoxs.vBoxSuperBroad,
        Expanded(
          child: _buildBodyView(),
        )
      ],
    );
    return Scaffold(
      backgroundColor: SColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: true,
        child: contentView,
      ),
    );
  }

  Widget _buildBodyView() {
    return _controller.isTransfer ? _buildTransferView() : _buildDefaultView();
  }

  Widget _buildTransferView() {
    Widget contentView = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalTextView(
            margin: EdgeInsets.symmetric(vertical: Dimens.margin_narrow),
            content: AppConfig
                .appS.main_activity_fragment_transfer_recipient_address_title,
            color: SColors.text_content,
            fontSize: Dimens.font_normal),
        NormalLoadingInputView(
          fontSize: Dimens.font_normal,
          hintText: _controller.coinSymbol == CoinSymbolUtil.coin_symbol_wxcash
              ? AppConfig.appS
                  .main_activity_fragment_transfer_recipient_wxcash_address_hint
              : AppConfig.appS
                  .main_activity_fragment_transfer_recipient_xcash_address_hint,
          padding: EdgeInsets.only(left: Dimens.margin_narrow),
          maxLines: 3,
          showLoading: false,
          onTextChange: (value) {
            _controller.address = value;
          },
        ),
        _controller.coinSymbol == CoinSymbolUtil.coin_symbol_wxcash
            ? Container()
            : NormalTextView(
                margin: EdgeInsets.symmetric(vertical: Dimens.margin_narrow),
                content: AppConfig
                    .appS.main_activity_fragment_transfer_payment_id_title,
                color: SColors.text_content,
                fontSize: Dimens.font_normal),
        _controller.coinSymbol == CoinSymbolUtil.coin_symbol_wxcash
            ? Container()
            : NormalLoadingInputView(
                fontSize: Dimens.font_normal,
                hintText: AppConfig
                    .appS.main_activity_fragment_transfer_payment_id_hint,
                padding: EdgeInsets.only(left: Dimens.margin_narrow),
                showLoading: false,
                onTextChange: (value) {
                  _controller.paymentId = value;
                },
              ),
        NormalTextView(
            margin: EdgeInsets.symmetric(vertical: Dimens.margin_narrow),
            content:
                AppConfig.appS.main_activity_fragment_transfer_amount_title,
            color: SColors.text_content,
            fontSize: Dimens.font_normal),
        NormalLoadingInputView(
          pattern: RegExp("[0-9.]"),
          fontSize: Dimens.font_normal,
          padding: EdgeInsets.only(left: Dimens.margin_narrow),
          showLoading: false,
          onTextChange: (value) {
            _controller.amount = value;
          },
          suffixView: NormalTextView(
              margin: EdgeInsets.symmetric(horizontal: Dimens.margin_narrow),
              content: _controller.coinSymbol,
              color: SColors.text_content,
              fontSize: Dimens.font_normal),
        ),
        DimenBoxs.vBoxSuperBroad,
        NormalButtonView(
          text: AppConfig.appS.main_activity_fragment_transfer_send_text,
          showStroke: false,
          color: SColors.primary,
          radius: Dimens.radius_narrow,
          fontSize: Dimens.font_narrow,
          textColor: SColors.main_help,
          height: Dimens.button_height_normal,
          onClick: () {
            _controller.doTransferCheck();
          },
        ),
      ],
    );
    return Container(
      child: contentView,
      margin: EdgeInsets.all(Dimens.margin_normal),
    );
  }

  Widget _buildDefaultView() {
    return Container(
      child: PullRefreshView(
        pullRefreshController: _controller.pullRefreshController,
        canLoadMore: true,
        topViewBuilder: _buildTopView,
        builder: (context, position) {
          Transfer transfer = _controller.pullRefreshController.datas[position];
          return MainActivityFragmentTransferItem(
            data: transfer,
            onClick: () {
              _controller.jumpToTransferDetailsActivity(transfer);
            },
          );
        },
        onRefresh: () async {
          _controller.initData();
        },
        onLoad: () async {
          _controller.getTransfers(false);
        },
      ),
      margin: EdgeInsets.all(Dimens.margin_normal),
    );
  }

  Widget _buildTopView(int itemLength) {
    Widget contentView = Row(
      children: [
        Expanded(
          child: GestureDetector(
              onTap: () {
                _controller.openNewTransfer();
              },
              behavior: HitTestBehavior.translucent,
              child: Column(
                children: [
                  NormalImageView(
                    width: Dimens.font_max_broad,
                    assetUrl: AssetImageConfig.transfer,
                    color: SColors.primary,
                  ),
                  DimenBoxs.vBoxSuperNarrow,
                  NormalTextView(
                      content: AppConfig.appS
                          .main_activity_fragment_transfer_new_transfer_text,
                      color: SColors.primary,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      fontSize: Dimens.font_normal)
                ],
              )),
          flex: 1,
        ),
        Expanded(
          child: Column(
            children: [
              NormalImageView(
                margin: EdgeInsets.all(Dimens.margin_normal),
                width: Dimens.font_super_broad * 3,
                assetUrl: AssetImageConfig.xcash_logo,
              ),
              DimenBoxs.vBoxSuperNarrow,
              NormalTextView(
                  content: _controller.getAmount().toString() +
                      " " +
                      (_controller.coinSymbol ?? ""),
                  color: SColors.text_title,
                  fontSize: Dimens.font_broad),
              DimenBoxs.vBoxSuperNarrow,
              NormalTextView(
                  content: _controller.getAmountUsd().toStringAsFixed(6) +
                      " " +
                      AppConfig.appS.usd_unit_text,
                  color: SColors.text_hint,
                  fontSize: Dimens.font_broad),
            ],
          ),
          flex: 3,
        ),
        Expanded(
          child: GestureDetector(
              onTap: () {
                _controller.doRefresh();
              },
              behavior: HitTestBehavior.translucent,
              child: Column(
                children: [
                  RotationTransition(
                    alignment: Alignment.center,
                    turns: _controller.animationController,
                    child: NormalImageView(
                      width: Dimens.font_max_broad,
                      assetUrl: AssetImageConfig.synchronize,
                      color: SColors.primary,
                    ),
                  ),
                  DimenBoxs.vBoxSuperNarrow,
                  NormalTextView(
                      content: AppConfig
                          .appS.main_activity_fragment_transfer_refresh_text,
                      color: SColors.primary,
                      fontSize: Dimens.font_normal),
                ],
              )),
          flex: 1,
        )
      ],
    );
    return Column(
      children: [
        Row(
          children: [
            NormalTextView(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: Dimens.margin_narrow),
                content: AppConfig
                    .appS.main_activity_fragment_transfer_create_transfer_title,
                color: SColors.text_content,
                fontSize: Dimens.font_normal),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                _controller.jumpToSwapActivity();
              },
              child: NormalTextView(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(vertical: Dimens.margin_narrow),
                  content:
                      AppConfig.appS.main_activity_fragment_transfer_swap_title,
                  color: SColors.primary,
                  textAlign: TextAlign.center,
                  fontSize: Dimens.font_normal),
            )
          ],
        ),
        Container(
          child: contentView,
          padding: EdgeInsets.all(Dimens.margin_normal),
          decoration: BoxDecoration(
            color: SColors.main_help,
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.radius_normal),
            ),
          ),
        ),
        DimenBoxs.vBoxSuperNarrow,
      ],
    );
  }
}

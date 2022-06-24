import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:framework/base/base_activity.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/configs/assets_config.dart';
import 'package:x_bank/controllers/web_view_activity_controller.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/js_bridge/js_bridge_view.dart';
import 'package:x_bank/widgets/normal/normal_image_view.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';
import 'package:x_bank/widgets/normal/normal_toolbar_view.dart';

import 'new_base_activity.dart';

class WebViewActivity extends NewBaseActivity {
  WebViewActivity(bundle) : super(bundle: bundle);

  @override
  BaseActivityState getState() => WebViewActivityState();
}

class WebViewActivityState extends NewBaseActivityState<WebViewActivity>
    with TickerProviderStateMixin {
  WebViewActivityController _controller = WebViewActivityController();

  @override
  BaseController initController() {
    _controller.animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    return _controller;
  }

  @override
  Widget buildViews(BuildContext context) {
    return NormalToolbarView(
      systemUiOverlayStyle: SystemUiOverlayStyle.light,
      showBack: true,
      backgroundColor: SColors.primary,
      contentColor: SColors.main_help,
      bodyColor: SColors.main_help,
      middle: _buildMiddleTitleView(),
      onBackClick: () {
        _controller.doBack();
      },
      body: _buildBodyView(),
    );
  }

  Widget _buildMiddleTitleView() {
    return NormalTextView(
        alignment: Alignment.center,
        content: _controller.title,
        fontSize: Dimens.font_broad,
        fontWeight: FontWeight.w600,
        color: SColors.main_help);
  }

  Widget _buildRightTitleView() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Dimens.margin_normal,
          vertical: Dimens.margin_super_narrow),
      child: Row(
        children: [
          DimenBoxs.hBoxNormal,
          RotationTransition(
            alignment: Alignment.center,
            turns: _controller.animationController!,
            child: NormalImageView(
              useMaterial: false,
              assetUrl: AssetImageConfig.webview_refresh,
              width: Dimens.webview_menu_icon_width,
              height: Dimens.webview_menu_icon_width,
              onClick: () {
                _controller.doRefresh();
              },
            ),
          ),
          Container(
            child: Container(
              width: Dimens.line_normal,
              height: Dimens.webview_menu_icon_width,
              color: SColors.main_help,
            ),
            margin: EdgeInsets.symmetric(horizontal: Dimens.margin_normal),
          ),
          NormalImageView(
            useMaterial: false,
            assetUrl: AssetImageConfig.webview_close,
            width: Dimens.webview_menu_icon_width,
            height: Dimens.webview_menu_icon_width,
            onClick: () {
              finish();
            },
          ),
          DimenBoxs.hBoxNormal,
        ],
      ),
      decoration: BoxDecoration(
        color: SColors.primary,
        borderRadius:
            BorderRadius.all(Radius.circular(Dimens.webview_menu_icon_width)),
      ),
    );
  }

  Widget _buildProgressBarView(int progress, BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.white54.withOpacity(0),
      value: progress == 1.0 ? 0 : progress / 100.0,
      valueColor: AlwaysStoppedAnimation<Color>(SColors.primary),
    );
  }

  Widget _buildBodyView() {
    Widget contentView = JsBridgeView(
      key: _controller.jsBridgeViewStateKey,
      url: _controller.url ?? "",
      pageLoadingCallback: (value) {
        _controller.updateProgress(value);
      },
      jsBridgeEventCallback: (JsBridgeEvent jsBridgeEvent, bool isSuccess,
          String? messageKey, dynamic data) {
        _controller.processJsBridgeEvent(
            jsBridgeEvent, isSuccess, messageKey, data);
      },
      showView: true,
      javaScriptChannels: ["bridge"],
    );
    return Column(
      children: [
        PreferredSize(
          child: _buildProgressBarView(_controller.lineProgress, context),
          preferredSize: Size.fromHeight(Dimens.line_broad),
        ),
        Expanded(child: contentView)
      ],
    );
  }
}

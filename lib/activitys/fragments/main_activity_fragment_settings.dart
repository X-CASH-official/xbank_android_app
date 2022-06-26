import 'package:flutter/material.dart';
import 'package:framework/base/base_activity.dart';
import 'package:framework/base/base_fragment.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/assets_config.dart';
import 'package:x_bank/controllers/fragments/main_activity_fragment_settings_controller.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_icon_view.dart';
import 'package:x_bank/widgets/normal/normal_image_view.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';

import 'new_base_fragment.dart';

class MainActivityFragmentSettings extends NewBaseFragment {
  MainActivityFragmentSettings(BaseActivityState baseActivityState,
      {Key? key, Bundle? bundle})
      : super(baseActivityState, key: key, bundle: bundle);

  @override
  BaseFragmentState getState() => MainActivityFragmentSettingsState();
}

class MainActivityFragmentSettingsState
    extends NewBaseFragmentState<MainActivityFragmentSettings> {
  MainActivityFragmentSettingsController _controller =
      MainActivityFragmentSettingsController();

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
            content: AppConfig.appS.main_activity_tab_settings,
            color: SColors.text_title,
            margin: EdgeInsets.all(Dimens.margin_normal),
            fontSize: Dimens.font_max_broad),
        DimenBoxs.vBoxSuperBroad,
        Expanded(
          child: SingleChildScrollView(
            controller: _controller.scrollController,
            child: _buildBodyView(),
          ),
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
    Widget contentView = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalTextView(
            margin: EdgeInsets.symmetric(vertical: Dimens.margin_narrow),
            content:
                AppConfig.appS.main_activity_fragment_settings_account_title,
            color: SColors.text_content,
            fontSize: Dimens.font_normal),
        _buildContentView()
      ],
    );
    return Container(
      child: contentView,
      margin: EdgeInsets.all(Dimens.margin_normal),
    );
  }

  Widget _buildContentView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopView(),
        DimenBoxs.vBoxSuperBroad,
        NormalTextView(
            margin: EdgeInsets.symmetric(vertical: Dimens.margin_narrow),
            content:
                AppConfig.appS.main_activity_fragment_settings_password_title,
            color: SColors.text_content,
            fontSize: Dimens.font_normal),
        _buildPasswordView(),
        DimenBoxs.vBoxBroad,
        NormalTextView(
            margin: EdgeInsets.symmetric(vertical: Dimens.margin_narrow),
            content:
                AppConfig.appS.main_activity_fragment_settings_privacy_title,
            color: SColors.text_content,
            fontSize: Dimens.font_normal),
        _buildPrivacyView(),
        DimenBoxs.vBoxBroad,
        _buildLogOutView()
      ],
    );
  }

  Widget _buildTopView() {
    Widget contentView = Row(
      children: [
        NormalImageView(
          width: Dimens.main_activity_fragment_settings_user_avatar_width,
          assetUrl: AssetImageConfig.user_avatar,
        ),
        DimenBoxs.hBoxNormal,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NormalTextView(
                  content: _controller.getEmail(),
                  color: SColors.text_title,
                  fontSize: Dimens.font_broad),
              DimenBoxs.vBoxSuperNarrow,
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: NormalTextView(
                    content: _controller.getUserId(),
                    color: SColors.text_hint,
                    fontSize: Dimens.font_narrow),
                onTap: () {
                  _controller.copyId();
                },
              ),
            ],
          ),
          flex: 1,
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

  Widget _buildPasswordView() {
    Widget contentView = Row(
      children: [
        Expanded(
          child: NormalTextView(
              content:
                  AppConfig.appS.main_activity_fragment_settings_password_text,
              color: SColors.text_title,
              fontSize: Dimens.font_broad),
          flex: 1,
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
          onTap: () {
            _controller.jumpToChangePasswordActivity();
          },
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

  Widget _buildPrivacyView() {
    Widget contentView = Row(
      children: [
        Expanded(
          child: NormalTextView(
              content:
                  AppConfig.appS.main_activity_fragment_settings_about_text,
              color: SColors.text_hint,
              fontSize: Dimens.font_broad),
          flex: 1,
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
          onTap: () {
            _controller.enterAboutUs();
          },
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

  Widget _buildLogOutView() {
    Widget contentView = Row(
      children: [
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: NormalTextView(
                content:
                    AppConfig.appS.main_activity_fragment_settings_log_out_text,
                color: SColors.log_out,
                fontSize: Dimens.font_broad),
            onTap: () {
              _controller.loginOut();
            },
          ),
          flex: 1,
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
      child: contentView,
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

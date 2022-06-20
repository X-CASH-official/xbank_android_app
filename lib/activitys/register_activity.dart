import 'package:flutter/material.dart';
import 'package:framework/base/base_activity.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/activitys/views/normal_loading_input_view.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/assets_config.dart';
import 'package:x_bank/controllers/register_activity_controller.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_button_view.dart';
import 'package:x_bank/widgets/normal/normal_image_view.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';
import 'package:x_bank/widgets/normal/normal_toolbar_view.dart';

import 'new_base_activity.dart';

class RegisterActivity extends NewBaseActivity {
  RegisterActivity(bundle) : super(bundle: bundle);

  @override
  BaseActivityState getState() => RegisterActivityState();
}

class RegisterActivityState extends NewBaseActivityState<RegisterActivity> {
  RegisterActivityController _controller = RegisterActivityController();

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
      title: AppConfig.appS.register_activity_register_title,
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
            NormalImageView(
                margin: EdgeInsets.only(
                    top: Dimens.login_activity_top_background_margin_top,
                    left: Dimens.margin_normal,
                    right: Dimens.margin_normal),
                width: Dimens.login_activity_top_background_width,
                assetUrl: AssetImageConfig.login_top_background,
                fit: BoxFit.cover),
            DimenBoxs.vBoxSuperBroad,
            DimenBoxs.vBoxSuperBroad,
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.margin_normal),
              child: _buildLoginView(),
            )
          ]),
    );
  }

  Widget _buildLoginView() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      DimenBoxs.vBoxNormal,
      NormalLoadingInputView(
        fontSize: Dimens.font_broad,
        hintText: AppConfig.appS.register_activity_first_name_hint,
        padding: EdgeInsets.only(left: Dimens.margin_narrow),
        onTextChange: (value) {
          _controller.firstName = value;
        },
      ),
      DimenBoxs.vBoxNormal,
      NormalLoadingInputView(
        fontSize: Dimens.font_broad,
        hintText: AppConfig.appS.register_activity_last_name_hint,
        padding: EdgeInsets.only(left: Dimens.margin_narrow),
        obscureText: false,
        onTextChange: (value) {
          _controller.lastName = value;
        },
      ),
      DimenBoxs.vBoxNormal,
      NormalLoadingInputView(
        fontSize: Dimens.font_broad,
        hintText: AppConfig.appS.register_activity_email_hint,
        padding: EdgeInsets.only(left: Dimens.margin_narrow),
        obscureText: false,
        onTextChange: (value) {
          _controller.email = value;
        },
      ),
      DimenBoxs.vBoxNormal,
      NormalLoadingInputView(
        fontSize: Dimens.font_broad,
        hintText: AppConfig.appS.register_activity_password_hint,
        padding: EdgeInsets.only(left: Dimens.margin_narrow),
        obscureText: true,
        onTextChange: (value) {
          _controller.password = value;
        },
      ),
      DimenBoxs.vBoxNormal,
      NormalLoadingInputView(
        fontSize: Dimens.font_broad,
        hintText: AppConfig.appS.register_activity_confirm_password_hint,
        padding: EdgeInsets.only(left: Dimens.margin_narrow),
        obscureText: true,
        onTextChange: (value) {
          _controller.confirmPassword = value;
        },
      ),
      DimenBoxs.vBoxNormal,
      NormalLoadingInputView(
        fontSize: Dimens.font_broad,
        hintText: AppConfig.appS.register_activity_referral_id_hint,
        padding: EdgeInsets.only(left: Dimens.margin_narrow),
        obscureText: false,
        onTextChange: (value) {
          _controller.referrailId = value;
        },
      ),
      DimenBoxs.vBoxNormal,
      DimenBoxs.vBoxSuperBroad,
      NormalButtonView(
        text: AppConfig.appS.register_activity_register_text,
        showStroke: false,
        color: SColors.primary,
        radius: Dimens.radius_narrow,
        fontSize: Dimens.font_narrow,
        textColor: SColors.main_help,
        height: Dimens.button_height_normal,
        onClick: () {
          _controller.doRegist();
        },
      ),
      DimenBoxs.vBoxNormal,
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _controller.jumpToLoginActivity();
        },
        child: NormalTextView(
            alignment: Alignment.center,
            content: AppConfig.appS.register_activity_login_text,
            fontSize: Dimens.font_narrow,
            color: SColors.primary),
      ),
      DimenBoxs.vBoxNormal,
    ]);
  }
}

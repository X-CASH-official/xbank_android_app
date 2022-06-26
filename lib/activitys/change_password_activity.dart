import 'package:flutter/material.dart';
import 'package:framework/base/base_activity.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/activitys/views/normal_loading_input_view.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/assets_config.dart';
import 'package:x_bank/controllers/change_password_activity_controller.dart';
import 'package:x_bank/controllers/login_activity_controller.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_button_view.dart';
import 'package:x_bank/widgets/normal/normal_image_view.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';
import 'package:x_bank/widgets/normal/normal_toolbar_view.dart';

import 'new_base_activity.dart';

class ChangePasswordActivity extends NewBaseActivity {
  ChangePasswordActivity(bundle) : super(bundle: bundle);

  @override
  BaseActivityState getState() => ChangePasswordActivityState();
}

class ChangePasswordActivityState
    extends NewBaseActivityState<ChangePasswordActivity> {
  ChangePasswordActivityController _controller =
      ChangePasswordActivityController();

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
      title: AppConfig.appS.change_password_activity_title,
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
            NormalImageView(
                margin: EdgeInsets.only(
                    top: Dimens.login_activity_top_background_margin_top,
                    left: Dimens.margin_normal,
                    right: Dimens.margin_normal),
                width: Dimens.login_activity_top_background_width,
                assetUrl: AssetImageConfig.login_top_background,
                fit: BoxFit.cover),
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
      NormalTextView(
          alignment: Alignment.centerLeft,
          content: AppConfig.appS.change_password_activity_old_password_text,
          color: SColors.text_title,
          fontSize: Dimens.font_broad),
      DimenBoxs.vBoxNarrow,
      NormalLoadingInputView(
        fontSize: Dimens.font_broad,
        hintText: AppConfig.appS.change_password_activity_old_password_hint,
        padding: EdgeInsets.only(left: Dimens.margin_narrow),
        obscureText: true,
        onTextChange: (value) {
          _controller.oldPassword = value;
        },
      ),
      DimenBoxs.vBoxNormal,
      NormalTextView(
          alignment: Alignment.centerLeft,
          content: AppConfig.appS.change_password_activity_password_text,
          color: SColors.text_title,
          fontSize: Dimens.font_broad),
      DimenBoxs.vBoxNarrow,
      NormalLoadingInputView(
        fontSize: Dimens.font_broad,
        hintText: AppConfig.appS.change_password_activity_password_hint,
        padding: EdgeInsets.only(left: Dimens.margin_narrow),
        obscureText: true,
        onTextChange: (value) {
          _controller.password = value;
        },
        showLoading: false,
      ),
      DimenBoxs.vBoxNormal,
      NormalTextView(
          alignment: Alignment.centerLeft,
          content:
              AppConfig.appS.change_password_activity_confirm_password_text,
          color: SColors.text_title,
          fontSize: Dimens.font_broad),
      DimenBoxs.vBoxNarrow,
      NormalLoadingInputView(
        fontSize: Dimens.font_broad,
        hintText: AppConfig.appS.change_password_activity_confirm_password_hint,
        padding: EdgeInsets.only(left: Dimens.margin_narrow),
        obscureText: true,
        onTextChange: (value) {
          _controller.confirmPassword = value;
        },
        showLoading: false,
      ),
      DimenBoxs.vBoxSuperBroad,
      NormalButtonView(
        text: AppConfig.appS.change_password_activity_commit_text,
        showStroke: false,
        color: SColors.primary,
        radius: Dimens.radius_narrow,
        fontSize: Dimens.font_narrow,
        textColor: SColors.main_help,
        height: Dimens.button_height_normal,
        onClick: () {
          _controller.doChangePassword();
        },
      ),
      DimenBoxs.vBoxNormal,
    ]);
  }
}

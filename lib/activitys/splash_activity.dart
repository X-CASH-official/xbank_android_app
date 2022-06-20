import 'package:flutter/material.dart';
import 'package:framework/base/base_activity.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/assets_config.dart';
import 'package:x_bank/controllers/splash_activity_controller.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_image_view.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';

import 'new_base_activity.dart';

class SplashActivity extends NewBaseActivity {
  SplashActivity() : super();

  @override
  BaseActivityState getState() => SplashActivityState();
}

class SplashActivityState extends NewBaseActivityState<SplashActivity> {
  SplashActivityController _controller = SplashActivityController();

  @override
  BaseController initController() {
    return _controller;
  }

  @override
  Widget buildViews(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: SColors.main_help,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackgroundView(),
          Align(
            child: _buildIconView(),
            alignment: Alignment.topCenter,
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundView() {
    return Container();
  }

  Widget _buildIconView() {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        NormalImageView(
            margin: EdgeInsets.only(top: Dimens.margin_super_broad),
            width: Dimens.splash_activity_icon_width,
            height: Dimens.splash_activity_icon_width,
            assetUrl: AssetImageConfig.icon,
            fit: BoxFit.cover),
        DimenBoxs.vBoxBroad,
        NormalTextView(
            content: AppConfig.appS.app_name,
            color: SColors.text_title,
            fontSize: Dimens.font_super_broad),
      ]),
    );
  }
}

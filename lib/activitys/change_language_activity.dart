import 'package:flutter/material.dart';
import 'package:framework/base/base_activity.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/activitys/views/language_item_view.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/controllers/change_language_activity_controller.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_toolbar_view.dart';

import 'new_base_activity.dart';

class ChangeLanguageActivity extends NewBaseActivity {
  ChangeLanguageActivity(bundle) : super(bundle: bundle);

  @override
  BaseActivityState getState() => ChangeLanguageActivityState();
}

class ChangeLanguageActivityState
    extends NewBaseActivityState<ChangeLanguageActivity> {
  ChangeLanguageActivityController _controller =
      ChangeLanguageActivityController();

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
      title: AppConfig.appS.change_language_activity_title,
      onBackClick: () {
        finish();
      },
      body: _buildBodyView(),
    );
  }

  Widget _buildBodyView() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(Dimens.margin_normal),
        child: _buildContentView(),
      ),
    );
  }

  Widget _buildContentView() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      LanguageItemView(
        title: AppConfig.appS.change_language_activity_english_text,
        onClick: () {
          _controller.updateLanguage(0);
        },
      ),
      DimenBoxs.vBoxNormal,
      LanguageItemView(
        title: AppConfig.appS.change_language_activity_chinese_text,
        onClick: () {
          _controller.updateLanguage(1);
        },
      ),
    ]);
  }
}

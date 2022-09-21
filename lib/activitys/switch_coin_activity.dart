import 'package:flutter/material.dart';
import 'package:framework/base/base_activity.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/activitys/views/switch_coin_item_view.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/controllers/switch_coin_activity_controller.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_toolbar_view.dart';

import 'new_base_activity.dart';

class SwitchCoinActivity extends NewBaseActivity {
  SwitchCoinActivity(bundle) : super(bundle: bundle);

  @override
  BaseActivityState getState() => SwitchCoinActivityState();
}

class SwitchCoinActivityState extends NewBaseActivityState<SwitchCoinActivity> {
  SwitchCoinActivityController _controller = SwitchCoinActivityController();

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
      title: AppConfig.appS.switch_coin_activity_title,
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
      SwitchCoinItemView(
        title: AppConfig.appS.switch_coin_activity_xcash_text,
        isSelect: _controller.selectIndex == 0,
        onClick: () {
          _controller.selectCoinSymbol(0);
        },
      ),
      DimenBoxs.vBoxNormal,
      SwitchCoinItemView(
        title: AppConfig.appS.switch_coin_activity_wxcash_text,
        isSelect: _controller.selectIndex == 1,
        onClick: () {
          _controller.selectCoinSymbol(1);
        },
      ),
    ]);
  }
}

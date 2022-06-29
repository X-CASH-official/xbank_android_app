import 'package:flutter/material.dart';
import 'package:framework/base/base_activity.dart';
import 'package:framework/base/base_fragment.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/assets_config.dart';
import 'package:x_bank/controllers/fragments/main_activity_fragment_home_controller.dart';
import 'package:x_bank/models/transfer.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_image_view.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';
import 'package:x_bank/widgets/pull_refresh_view.dart';

import 'items/main_activity_fragment_transfer_item.dart';
import 'new_base_fragment.dart';

class MainActivityFragmentHome extends NewBaseFragment {
  MainActivityFragmentHome(BaseActivityState baseActivityState,
      {Key? key, Bundle? bundle})
      : super(baseActivityState, key: key, bundle: bundle);

  @override
  BaseFragmentState getState() => MainActivityFragmentHomeState();
}

class MainActivityFragmentHomeState
    extends NewBaseFragmentState<MainActivityFragmentHome> {
  MainActivityFragmentHomeController _controller =
      MainActivityFragmentHomeController();

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
            content: AppConfig.appS.main_activity_tab_home,
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
      resizeToAvoidBottomInset: true,
      backgroundColor: SColors.background,
      body: SafeArea(
        top: true,
        child: contentView,
      ),
    );
  }

  Widget _buildBodyView() {
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
                  content: (_controller.usersAccountsBalanceSummaryResponseData
                              ?.xcash_balance ??
                          "0") +
                      " " +
                      AppConfig.appS.xcash_unit_text,
                  color: SColors.text_title,
                  fontSize: Dimens.font_broad),
              DimenBoxs.vBoxSuperNarrow,
              NormalTextView(
                  content: (_controller.usersAccountsBalanceSummaryResponseData
                              ?.usd_balance ??
                          "0") +
                      " " +
                      AppConfig.appS.usd_unit_text,
                  color: SColors.text_hint,
                  fontSize: Dimens.font_broad),
            ],
          ),
          flex: 1,
        )
      ],
    );
    return Column(
      children: [
        NormalTextView(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(vertical: Dimens.margin_narrow),
            content: AppConfig.appS.main_activity_fragment_home_balance_title,
            color: SColors.text_content,
            fontSize: Dimens.font_normal),
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

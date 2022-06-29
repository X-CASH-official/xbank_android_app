import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/base/base_fragment.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/utils/toast_util.dart';
import 'package:x_bank/activitys/fragments/main_activity_fragment_deposit.dart';
import 'package:x_bank/activitys/fragments/main_activity_fragment_home.dart';
import 'package:x_bank/activitys/fragments/main_activity_fragment_settings.dart';
import 'package:x_bank/activitys/fragments/main_activity_fragment_transfer.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/assets_config.dart';
import 'package:x_bank/models/extra/tab_item.dart';
import 'package:x_bank/resources/s_colors.dart';

import 'extra/application_controller.dart';
import 'fragments/main_activity_fragment_home_controller.dart';
import 'fragments/main_activity_fragment_transfer_controller.dart';

class MainActivityController extends BaseController {
  late ApplicationController applicationController;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<TabItem> tabItems = [];
  final List<BaseFragment> fragments = [];

  int currentIndex = 0;
  int last = 0;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    initTabs();
    initFragments();
    postFrameCallback((callback) async {
      await applicationController.getAccount();
    });
  }

  void initTabs() {
    tabItems.clear();
    tabItems.add(TabItem(AppConfig.appS.main_activity_tab_home,
        AssetImageConfig.menu_home, SColors.text_title, SColors.primary));
    tabItems.add(TabItem(AppConfig.appS.main_activity_tab_deposit,
        AssetImageConfig.menu_desposit, SColors.text_title, SColors.primary));
    tabItems.add(TabItem(AppConfig.appS.main_activity_tab_transfer,
        AssetImageConfig.menu_transfer, SColors.text_title, SColors.primary));
    tabItems.add(TabItem(AppConfig.appS.main_activity_tab_settings,
        AssetImageConfig.menu_settings, SColors.text_title, SColors.primary));
  }

  void initFragments() {
    fragments.clear();
    fragments.add(MainActivityFragmentHome(baseActivityState));
    fragments.add(MainActivityFragmentDeposit(baseActivityState));
    fragments.add(MainActivityFragmentTransfer(baseActivityState));
    fragments.add(MainActivityFragmentSettings(baseActivityState));
  }

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void refresh() {
    if (fragments.length < 4) {
      return;
    }
    ((fragments[0] as MainActivityFragmentHome).stateCache.state?.baseController
            as MainActivityFragmentHomeController)
        .initData();
    ((fragments[2] as MainActivityFragmentTransfer)
            .stateCache
            .state
            ?.baseController as MainActivityFragmentTransferController)
        .initData();
  }

  void refreshFragments() {
    //Called in MainActivityState, if call in the change language page, the state may be not found
    fragments.forEach((item) {
      (item.stateCache.state?.baseController)?.notifyListeners();
    });
  }

  void updateLanguage() {
    initTabs();
    notifyListeners();
  }

  Future<bool> exitApp() async {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - last > 2000) {
      last = now;
      ToastUtil.showShortToast(AppConfig.appS.exit_tips);
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/utils/toast_util.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/router_config.dart';
import 'package:x_bank/models/extra/accounts.dart';
import 'package:x_bank/models/user_info.dart';
import 'package:x_bank/utils/clipboard_util.dart';
import 'package:x_bank/utils/coin_symbol_util.dart';
import 'package:x_bank/utils/navigator_util.dart';

import '../extra/application_controller.dart';

class MainActivityFragmentSettingsController extends BaseController {
  late ApplicationController applicationController;
  final ScrollController scrollController = ScrollController();
  UserInfo? userInfo;
  Accounts? accounts;
  String? coinSymbol;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    updateCoinSymbol();
    postFrameCallback((callback) async {
      await initData();
    });
  }

  Future<void> initData() async {
    userInfo = await applicationController.getUserInfo();
    accounts = await applicationController.getAccounts();
    notifyListeners();
  }

  String getEmail() {
    if (userInfo == null) {
      return "";
    }
    return userInfo!.username ?? "";
  }

  String getUserId() {
    if (userInfo == null) {
      return "";
    }
    return userInfo!.user_id ?? "";
  }

  void copyId() {
    ClipboardUtil.setData(getUserId());
    ToastUtil.showShortToast(AppConfig.appS.copy_success);
  }

  void loginOut() {
    ApplicationController.getInstance().loginOut(
        AppConfig.navigatorStateKey.currentContext!,
        showTokenTips: false);
  }

  void enterAboutUs() {
    applicationController.enterWebViewActivity(
        context,
        AppConfig.appS.main_activity_fragment_settings_about_text,
        AppConfig.appS.main_activity_fragment_settings_about_us_url);
  }

  void jumpToChangePasswordActivity() async {
    NavigatorUtil.jumpTo(context, ActivityName.ChangePasswordActivity);
  }

  void jumpToChangeLanguageActivity() {
    NavigatorUtil.jumpTo(context, ActivityName.ChangeLanguageActivity);
  }

  void jumpToSwitchCoinActivity() {
    NavigatorUtil.jumpTo(context, ActivityName.SwitchCoinActivity);
  }

  Future<void> updateCoinSymbol() async {
    coinSymbol = CoinSymbolUtil.getSelectCoinSymbol();
    await initData();
    // notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

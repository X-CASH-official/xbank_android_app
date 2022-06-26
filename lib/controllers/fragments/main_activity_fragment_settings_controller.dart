import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/router_config.dart';
import 'package:x_bank/models/account.dart';
import 'package:x_bank/models/user_info.dart';
import 'package:x_bank/utils/navigator_util.dart';

import '../extra/application_controller.dart';

class MainActivityFragmentSettingsController extends BaseController {
  late ApplicationController applicationController;
  final ScrollController scrollController = ScrollController();
  UserInfo? userInfo;
  Account? account;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    postFrameCallback((callback) async {
      await initData();
    });
  }

  Future<void> initData() async {
    userInfo = await applicationController.getUserInfo();
    account = await applicationController.getAccount();
    notifyListeners();
  }

  String getEmail() {
    if (userInfo == null) {
      return "";
    }
    return userInfo!.username ?? "";
  }

  String getUserName() {
    if (userInfo == null) {
      return "";
    }
    return userInfo!.username ?? "";
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

  @override
  void dispose() {
    super.dispose();
  }
}

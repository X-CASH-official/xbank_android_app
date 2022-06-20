import 'package:flutter/cupertino.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/utils/network/method.dart';
import 'package:framework/utils/toast_util.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/router_config.dart';
import 'package:x_bank/configs/url_config.dart';
import 'package:x_bank/models/account.dart';
import 'package:x_bank/models/user_info.dart';
import 'package:x_bank/utils/navigator_util.dart';
import 'package:x_bank/utils/network_util.dart';
import 'package:x_bank/utils/view_util.dart';

import 'extra/application_controller.dart';

class LoginActivityController extends BaseController {
  late ApplicationController applicationController;
  String? account;
  String? password;
  String? code_2fa;

  bool showLoading = false;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    postFrameCallback((callback) async {});
  }

  Future<void> doLogin() async {
    if (account == null || password == null) {
      ToastUtil.showShortToast(
          AppConfig.appS.login_activity_account_or_password_empty_tips);
      return;
    }
    Map<String, dynamic> data = {};
    data["provider"] = "x-bank";
    data["username"] = account;
    data["captcha"] = AppConfig.reCaptchaDummyResponse;
    data["password"] = password;
    if (code_2fa != null) {
      data["code_2fa"] = code_2fa;
    }
    showLoading = true;
    notifyListeners();
    baseActivityState.baseDialogController?.show(AppConfig.appS.loading);
    await NetworkUtil.request<UserInfo>(Method.POST, UrlConfig.users_sign_in,
        data: data, successCallback: (data, baseEntity) async {
      bool isCode2fa = code_2fa != null;
      if (data != null) {
        String token = data.access_token ?? "";
        String refreshToken = data.refresh_token ?? "";
        applicationController.updateToken(token);
        applicationController.updateRefreshToken(refreshToken);
        applicationController.updateUserInfo(data);
        Account? account = await applicationController.getAccount(
            reLogin: false, showErrorTips: isCode2fa);
        if (account == null) {
          code_2fa = null;
          if (!isCode2fa) {
            ViewUtil.showPopup2faInputViewDialog(context, (value) {
              code_2fa = value;
            }, () {
              doLogin();
            });
          }
          return;
        }
        jumpToMainActivity();
      }
    }, errorCallback: (e) async {
      code_2fa = null;
      if (e.msg.contains("grecaptcha is not defined")) {
        ViewUtil.showPopup2faInputViewDialog(context, (value) {
          code_2fa = value;
        }, () {
          doLogin();
        });
      }
      ToastUtil.showShortToast(e.msg);
    });
    baseActivityState.baseDialogController?.hide();
    showLoading = false;
    notifyListeners();
  }

  void jumpToMainActivity() async {
    NavigatorUtil.jumpTo(context, ActivityName.MainActivity);
  }

  void jumpToRegisterActivity() async {
    NavigatorUtil.jumpTo(context, ActivityName.RegisterActivity);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

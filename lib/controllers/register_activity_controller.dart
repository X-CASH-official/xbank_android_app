import 'package:flutter/cupertino.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/utils/log_util.dart';
import 'package:framework/utils/network/method.dart';
import 'package:framework/utils/toast_util.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/router_config.dart';
import 'package:x_bank/configs/url_config.dart';
import 'package:x_bank/models/response/users_sign_up_response_data.dart';
import 'package:x_bank/utils/navigator_util.dart';
import 'package:x_bank/utils/network_util.dart';

import 'extra/application_controller.dart';

class RegisterActivityController extends BaseController {
  final String reCaptchaDummyResponse =
      "Cxq90JJMQbYIWAgPpCdQvnrSWOOZVwVSIaF2rYUdITaK2xs5SSB8I6s6uVmRjcdZ";

  late ApplicationController applicationController;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;
  String? referrailId;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    postFrameCallback((callback) async {});
  }

  void jumpToLoginActivity() async {
    NavigatorUtil.jumpTo(context, ActivityName.LoginActivity);
  }

  Future<void> doSendEmail() async {
    if (email == null) {
      ToastUtil.showShortToast(
          AppConfig.appS.register_activity_params_empty_tips);
      return;
    }
    Map<String, dynamic> data = {};
    data["username"] = email;
    data["provider"] = "x-bank";
    baseActivityState.baseDialogController?.show(AppConfig.appS.processing);
    await NetworkUtil.request<dynamic>(
        Method.POST, UrlConfig.users_email_resend_verification,
        data: data, showLog: true, successCallback: (data, baseEntity) async {
      if (data != null) {
        LogUtil.e(data);
      } else {
        ToastUtil.showShortToast(AppConfig.appS.server_error);
      }
    }, errorCallback: (e) async {
      ToastUtil.showShortToast(e.msg);
    });
    baseActivityState.baseDialogController?.hide();
  }

  Future<void> doRegist() async {
    if (firstName == null ||
        lastName == null ||
        email == null ||
        password == null ||
        confirmPassword == null) {
      ToastUtil.showShortToast(
          AppConfig.appS.register_activity_params_empty_tips);
      return;
    }
    if (password != confirmPassword) {
      ToastUtil.showShortToast(
          AppConfig.appS.register_activity_password_not_same_tips);
      return;
    }
    Map<String, dynamic> data = {};
    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data["provider"] = "x-bank";
    data["username"] = email;
    data["password"] = password;
    data["captcha"] = AppConfig.reCaptchaDummyResponse;
    data["referrer_user_id"] = referrailId;
    baseActivityState.baseDialogController?.show(AppConfig.appS.processing);
    await NetworkUtil.request<UsersSignUpResponseData>(
        Method.POST, UrlConfig.users_sign_up, data: data, showLog: true,
        successCallback: (data, baseEntity) async {
      if (data != null) {
        LogUtil.e(data);
        ToastUtil.showShortToast(
            AppConfig.appS.register_activity_register_success_tips);
      } else {
        ToastUtil.showShortToast(AppConfig.appS.server_error);
      }
    }, errorCallback: (e) async {
      ToastUtil.showShortToast(e.msg);
    });
    baseActivityState.baseDialogController?.hide();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

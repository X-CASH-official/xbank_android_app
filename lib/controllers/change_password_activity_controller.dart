import 'package:flutter/cupertino.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/utils/network/method.dart';
import 'package:framework/utils/toast_util.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/url_config.dart';
import 'package:x_bank/models/user_info.dart';
import 'package:x_bank/utils/network_util.dart';

import 'extra/application_controller.dart';

class ChangePasswordActivityController extends BaseController {
  late ApplicationController applicationController;
  String? oldPassword;
  String? password;
  String? confirmPassword;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    postFrameCallback((callback) async {});
  }

  Future<void> doChangePassword() async {
    if (oldPassword == null || password == null || confirmPassword == null) {
      ToastUtil.showShortToast(
          AppConfig.appS.change_password_activity_password_empty_tips);
      return;
    }
    if (password != confirmPassword) {
      ToastUtil.showShortToast(
          AppConfig.appS.change_password_activity_password_not_same_tips);
      return;
    }
    bool updateSuccess = false;
    Map<String, dynamic> data = {};
    data["password"] = oldPassword;
    data["new_password"] = password;
    baseActivityState.baseDialogController?.show(AppConfig.appS.loading);
    await NetworkUtil.request<UserInfo>(Method.PUT, UrlConfig.users_password,
        data: data, successCallback: (data, baseEntity) async {
      if (data != null) {
        String token = data.access_token ?? "";
        String refreshToken = data.refresh_token ?? "";
        applicationController.updateToken(token);
        applicationController.updateRefreshToken(refreshToken);
        applicationController.updateUserInfo(data);
        ToastUtil.showShortToast(AppConfig
            .appS.change_password_activity_update_password_success_tips);
        updateSuccess = true;
      }
    }, errorCallback: (e) async {
      ToastUtil.showShortToast(e.msg);
    });
    baseActivityState.baseDialogController?.hide();
    if (updateSuccess) {
      baseActivityState.finish();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

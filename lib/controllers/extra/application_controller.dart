import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/utils/device_util.dart';
import 'package:framework/utils/network/method.dart';
import 'package:framework/utils/shared_preferences_manager.dart';
import 'package:framework/utils/toast_util.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/key_config.dart';
import 'package:x_bank/configs/router_config.dart';
import 'package:x_bank/configs/url_config.dart';
import 'package:x_bank/models/account.dart';
import 'package:x_bank/models/transfer.dart';
import 'package:x_bank/models/user_info.dart';
import 'package:x_bank/utils/navigator_util.dart';
import 'package:x_bank/utils/network_util.dart';

class ApplicationController extends ChangeNotifier {
  late String version;
  UserInfo? userInfo;
  Account? account;

  static ApplicationController getInstance() {
    return Provider.of<ApplicationController>(
        AppConfig.navigatorStateKey.currentContext!,
        listen: false);
  }

  Future<void> init() async {
    if (DeviceUtil.isAndroid() || DeviceUtil.isIOS()) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      version = packageInfo.version;
    } else {
      version = "";
    }
    await AppConfig.initHttpManager(version);
  }

  void loginOut(BuildContext context, {bool showTokenTips = false}) {
    if (showTokenTips) {
      ToastUtil.showShortToast(AppConfig.appS.token_invalid_tips);
    }
    SharedPreferencesManager().remove(KeyConfig.sp_token_key);
    SharedPreferencesManager().remove(KeyConfig.sp_refresh_token_key);
    SharedPreferencesManager().remove(KeyConfig.sp_user_info_key);
    userInfo = null;
    account = null;
    NavigatorUtil.clearTo(context, ActivityName.LoginActivity);
  }

  Future<void> updateToken(String token) async {
    await SharedPreferencesManager().putString(KeyConfig.sp_token_key, token);
  }

  String? getToken() {
    return SharedPreferencesManager().getString(KeyConfig.sp_token_key);
  }

  Future<void> updateRefreshToken(String refreshToken) async {
    await SharedPreferencesManager()
        .putString(KeyConfig.sp_refresh_token_key, refreshToken);
  }

  String? getRefreshToken() {
    return SharedPreferencesManager().getString(KeyConfig.sp_refresh_token_key);
  }

  Future<void> updateUserInfo(UserInfo userInfo) async {
    this.userInfo = userInfo;
    await SharedPreferencesManager()
        .putObject(KeyConfig.sp_user_info_key, userInfo);
  }

  Future<UserInfo?> getUserInfo() async {
    if (userInfo != null) {
      return userInfo;
    }
    Map? userMap =
        SharedPreferencesManager().getObject(KeyConfig.sp_user_info_key);
    if (userMap != null && userMap is Map<String, dynamic>) {
      userInfo = UserInfo.fromJson(userMap);
    }
    return userInfo;
  }

  Future<Account?> getAccount(
      {bool reLogin = true, bool showErrorTips = true}) async {
    if (account != null) {
      return account;
    }
    UserInfo? userInfo = await getUserInfo();
    if (userInfo == null || userInfo.user_id == null) {
      return null;
    }
    Map<String, dynamic> query = {};
    await NetworkUtil.request<Account>(Method.GET,
        UrlConfig.users_account.replaceAll(UrlConfig.urlKey, userInfo.user_id!),
        query: query, successCallback: (data, baseEntity) async {
      if (data != null) {
        account = data;
      }
    }, errorCallback: (e) async {
      if (reLogin && e.code == 401) {
        ApplicationController.getInstance().loginOut(
            AppConfig.navigatorStateKey.currentContext!,
            showTokenTips: true);
        return;
      }
      if (showErrorTips) {
        ToastUtil.showShortToast(e.msg);
      }
    });
    return account;
  }

  Future<List<Transfer>?> getTransfers(Map<String, dynamic> query) async {
    List<Transfer>? transfers;
    Account? account = await getAccount();
    if (account == null || account.id == null) {
      return transfers;
    }
    await NetworkUtil.request<Transfer>(
        Method.GET,
        UrlConfig.users_transfers
            .replaceAll(UrlConfig.urlKey, userInfo!.user_id!)
            .replaceAll(UrlConfig.urlKey1, account.id!),
        isList: true,
        query: query, successListCallback: (data, baseEntity) async {
      transfers = data;
    }, errorCallback: (e) async {
      ToastUtil.showShortToast(e.msg);
    });
    return transfers;
  }

  void enterWebViewActivity(BuildContext context, String? title,String? url) {
    Bundle bundle=Bundle();
    bundle.putString(KeyConfig.web_view_title_key, title??"");
    bundle.putString(KeyConfig.web_view_url_key, url??"");
    NavigatorUtil.jumpTo(context, ActivityName.WebViewActivity,bundle: bundle);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

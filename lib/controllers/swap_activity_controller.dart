import 'package:flutter/cupertino.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/utils/network/method.dart';
import 'package:framework/utils/toast_util.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/url_config.dart';
import 'package:x_bank/models/account.dart';
import 'package:x_bank/models/extra/accounts.dart';
import 'package:x_bank/models/user_info.dart';
import 'package:x_bank/utils/coin_symbol_util.dart';
import 'package:x_bank/utils/network_util.dart';
import 'package:x_bank/utils/view_util.dart';

import 'extra/application_controller.dart';

class SwapActivityController extends BaseController {
  late ApplicationController applicationController;
  final TextEditingController textEditingTopController =
      TextEditingController();
  final TextEditingController textEditingBottomController =
      TextEditingController();

  Accounts? accounts;
  String? coinSymbol;
  String? swapAmount;

  String? targetCoinSymbol;
  String? code_2fa;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    updateCoinSymbol();
    targetCoinSymbol = coinSymbol;
    postFrameCallback((callback) async {
      await initData(refreshAccount: false);
    });
  }

  Future<void> initData({bool refreshAccount = true}) async {
    accounts = await applicationController.getAccounts(refresh: refreshAccount);
    notifyListeners();
  }

  double getAmount(String coinSymbol) {
    if (accounts == null) {
      return 0;
    }
    if (coinSymbol == CoinSymbolUtil.coin_symbol_wxcash) {
      if (accounts == null || accounts!.wxcashAccount == null) {
        return 0;
      }
      return (accounts!.wxcashAccount!.balance_atomic ?? 0) / 1000000;
    } else {
      if (accounts == null || accounts!.xcashAccount == null) {
        return 0;
      }
      return (accounts!.xcashAccount!.balance_atomic ?? 0) / 1000000;
    }
  }

  Future<void> doSwap() async {
    if (swapAmount == null) {
      ToastUtil.showShortToast(AppConfig.appS.swap_activity_amount_empty_tips);
      return;
    }
    UserInfo? userInfo = await applicationController.getUserInfo();
    Accounts? accounts = await applicationController.getAccounts();
    if (userInfo == null || userInfo.user_id == null || accounts == null) {
      ToastUtil.showShortToast(AppConfig.appS.account_error_tips);
      return;
    }
    Account? fromAccount = targetCoinSymbol == CoinSymbolUtil.coin_symbol_wxcash
        ? accounts.wxcashAccount
        : accounts.xcashAccount;
    Account? toAccount = targetCoinSymbol == CoinSymbolUtil.coin_symbol_wxcash
        ? accounts.xcashAccount
        : accounts.wxcashAccount;
    if (fromAccount == null ||
        toAccount == null ||
        fromAccount.id == null ||
        toAccount.id == null) {
      ToastUtil.showShortToast(AppConfig.appS.account_error_tips);
      return;
    }
    Map<String, dynamic> data = {};
    data["from_account_id"] = fromAccount.id;
    data["to_account_id"] = toAccount.id;
    data["atomic_amount"] = (double.parse(swapAmount!) * 1000000).floor();
    if (code_2fa != null) {
      data["code_2fa"] = code_2fa;
    }
    baseActivityState.baseDialogController?.show(AppConfig.appS.loading);
    await NetworkUtil.request<dynamic>(Method.POST,
        UrlConfig.users_swaps.replaceAll(UrlConfig.urlKey, userInfo.user_id!),
        data: data, successCallback: (data, baseEntity) async {
      if (data != null) {
        ToastUtil.showShortToast(AppConfig.appS.swap_activity_success_tips);
        await initData(refreshAccount: true);
      }
    }, errorCallback: (e) async {
      code_2fa = null;
      if (e.msg.contains("two factor")) {
        ViewUtil.showPopup2faInputViewDialog(context, (value) {
          code_2fa = value;
        }, () {
          doSwap();
        });
      } else {
        ToastUtil.showShortToast(e.msg);
      }
    });
    baseActivityState.baseDialogController?.hide();
  }

  Future<void> updateCoinSymbol() async {
    coinSymbol = CoinSymbolUtil.getSelectCoinSymbol();
    await initData(refreshAccount: true);
    notifyListeners();
  }

  void updateTargetCoinSymbol() async {
    if (targetCoinSymbol == CoinSymbolUtil.coin_symbol_wxcash) {
      targetCoinSymbol = CoinSymbolUtil.coin_symbol_xcash;
    } else {
      targetCoinSymbol = CoinSymbolUtil.coin_symbol_wxcash;
    }
    notifyListeners();
  }

  String getTopCoinSymbol() {
    return targetCoinSymbol ?? CoinSymbolUtil.coin_symbol_xcash;
  }

  String getBottomCoinSymbol() {
    String result;
    if (targetCoinSymbol == CoinSymbolUtil.coin_symbol_wxcash) {
      result = CoinSymbolUtil.coin_symbol_xcash;
    } else {
      result = CoinSymbolUtil.coin_symbol_wxcash;
    }
    return result;
  }

  void updateSwapAmount(String amount) async {
    swapAmount = amount;
    textEditingBottomController.text = amount;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

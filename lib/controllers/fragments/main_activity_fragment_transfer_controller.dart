import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/base/activity_manager.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/utils/network/method.dart';
import 'package:framework/utils/toast_util.dart';
import 'package:x_bank/activitys/main_activity.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/key_config.dart';
import 'package:x_bank/configs/router_config.dart';
import 'package:x_bank/configs/url_config.dart';
import 'package:x_bank/models/extra/accounts.dart';
import 'package:x_bank/models/response/users_accounts_balance_summary_response_data.dart';
import 'package:x_bank/models/transfer.dart';
import 'package:x_bank/models/user_info.dart';
import 'package:x_bank/utils/coin_symbol_util.dart';
import 'package:x_bank/utils/navigator_util.dart';
import 'package:x_bank/utils/network_util.dart';
import 'package:x_bank/utils/view_util.dart';
import 'package:x_bank/widgets/pull_refresh_view.dart';

import '../extra/application_controller.dart';
import '../main_activity_controller.dart';

class MainActivityFragmentTransferController extends BaseController {
  PullRefreshController pullRefreshController =
      PullRefreshController<Transfer>();

  bool isTransfer = false;
  late ApplicationController applicationController;
  String? address;
  String? paymentId;
  String? amount;
  Transfer? transfer;
  String? code_2fa;
  late AnimationController animationController;
  Accounts? accounts;
  double? amountUsdUnit;
  String? coinSymbol;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    updateCoinSymbol();
    postFrameCallback((callback) async {
      await initData(refreshAccount: false);
    });
  }

  Future<void> initData({bool refreshAccount = true}) async {
    accounts = await applicationController.getAccounts(refresh: refreshAccount);
    // await getBalanceSummary();
    await getTransfers(true);
  }

  double getAmount() {
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


  double getAmountUsd() {
    if (accounts == null) {
      return 0;
    }
    if (coinSymbol == CoinSymbolUtil.coin_symbol_wxcash) {
      if (accounts == null || accounts!.wxcashAccount == null) {
        return 0;
      }
      return accounts!.wxcashAccount!.balance_usd ?? 0;
    } else {
      if (accounts == null || accounts!.xcashAccount == null) {
        return 0;
      }
      return accounts!.xcashAccount!.balance_usd ?? 0;
    }
  }

  Future<void> getTransfers(bool isRefresh) async {
    pullRefreshController.checkResetIndex(isRefresh);
    Map<String, dynamic> query = {};
    query["page"] = pullRefreshController.index;
    query["page_size"] = 100;
    query["type"] = "out";
    List<Transfer>? transfers = await applicationController.getTransfers(query,coinSymbol == CoinSymbolUtil.coin_symbol_wxcash);
    if (transfers == null) {
      pullRefreshController.stopLoading(true);
      return;
    }
    pullRefreshController.addPage(isRefresh, transfers, transfers.length == 0);
  }

  Future<void> doTransferCheck() async {
    if (address == null) {
      ToastUtil.showShortToast(
          AppConfig.appS.main_activity_fragment_transfer_address_empty_tips);
      return;
    }
    if (amount == null) {
      ToastUtil.showShortToast(
          AppConfig.appS.main_activity_fragment_transfer_amount_empty_tips);
      return;
    }
    UserInfo? userInfo = await applicationController.getUserInfo();
    Accounts? accounts = await applicationController.getAccounts();
    if (userInfo == null ||
        userInfo.user_id == null ||
        accounts == null ||
        accounts.xcashAccount == null ||
        accounts.xcashAccount!.id == null) {
      return;
    }
    Map<String, dynamic> data = {};
    data["address"] = address;
    if (paymentId != null) {
      data["payment_id"] = paymentId;
    }
    data["atomic_amount"] = int.parse(amount!) * 1000000;
    if (coinSymbol != null) {
      data["currency"] = coinSymbol;
    }
    baseActivityState.baseDialogController?.show(AppConfig.appS.loading);
    await NetworkUtil.request<Transfer>(
        Method.POST,
        UrlConfig.users_transfers_check
            .replaceAll(UrlConfig.urlKey, userInfo.user_id!)
            .replaceAll(UrlConfig.urlKey1, accounts.xcashAccount!.id!),
        data: data, successCallback: (data, baseEntity) async {
      transfer = data;
      if (data != null) {
        ViewUtil.showPopupTransferConfirmViewDialog(context, data, () async {
          await sendTransfer();
        });
      }
    }, errorCallback: (e) async {
      ToastUtil.showShortToast(e.msg);
    });
    baseActivityState.baseDialogController?.hide();
  }

  Future<void> sendTransfer() async {
    if (address == null) {
      ToastUtil.showShortToast(
          AppConfig.appS.main_activity_fragment_transfer_address_empty_tips);
      return;
    }
    if (amount == null) {
      ToastUtil.showShortToast(
          AppConfig.appS.main_activity_fragment_transfer_amount_empty_tips);
      return;
    }
    UserInfo? userInfo = await applicationController.getUserInfo();
    Accounts? accounts = await applicationController.getAccounts();
    if (userInfo == null ||
        userInfo.user_id == null ||
        accounts == null ||
        accounts.xcashAccount == null ||
        accounts.xcashAccount!.id == null) {
      return;
    }
    Map<String, dynamic> data = {};
    data["address"] = address;
    if (paymentId != null) {
      data["payment_id"] = paymentId;
    }
    data["atomic_amount"] = int.parse(amount!) * 1000000;
    if (code_2fa != null) {
      data["code_2fa"] = code_2fa;
    }
    if (coinSymbol != null) {
      data["currency"] = coinSymbol;
    }
    baseActivityState.baseDialogController?.show(AppConfig.appS.loading);
    await NetworkUtil.request<Transfer>(
        Method.POST,
        UrlConfig.users_transfers
            .replaceAll(UrlConfig.urlKey, userInfo.user_id!)
            .replaceAll(UrlConfig.urlKey1, accounts.xcashAccount!.id!),
        data: data, successCallback: (data, baseEntity) async {
      ToastUtil.showShortToast(
          AppConfig.appS.main_activity_fragment_transfer_transfer_success_tips);
      isTransfer = false;
      await updateTransfers();
    }, errorCallback: (e) async {
      code_2fa = null;
      if (e.msg.contains("two factor")) {
        ViewUtil.showPopup2faInputViewDialog(context, (value) {
          code_2fa = value;
        }, () {
          sendTransfer();
        });
      } else {
        ToastUtil.showShortToast(e.msg);
      }
    });
    baseActivityState.baseDialogController?.hide();
  }

  Future<void> updateTransfers() async {
    (ActivityManager().getTargetActivity<MainActivityState>()?.baseController
            as MainActivityController)
        .refresh();
  }

  void jumpToTransferDetailsActivity(Transfer transfer) async {
    Bundle bundle = Bundle();
    bundle.putObject(KeyConfig.transfer_key, transfer);
    NavigatorUtil.jumpTo(context, ActivityName.TransferDetailsActivity,
        bundle: bundle);
  }

  Future<void> doRefresh() async {
    animationController.reset();
    animationController.forward();
    await initData();
  }

  void openNewTransfer() {
    isTransfer = true;
    notifyListeners();
  }

  void closeNewTransfer() {
    isTransfer = false;
    notifyListeners();
  }

  Future<void> updateCoinSymbol() async {
    coinSymbol = CoinSymbolUtil.getSelectCoinSymbol();
    await initData();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/utils/network/method.dart';
import 'package:framework/utils/toast_util.dart';
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
import 'package:x_bank/widgets/pull_refresh_view.dart';

import '../extra/application_controller.dart';

class MainActivityFragmentHomeController extends BaseController {
  PullRefreshController pullRefreshController =
      PullRefreshController<Transfer>();

  late ApplicationController applicationController;

  Accounts? accounts;
  double? amountUsdUnit;
  String? coinSymbol;
  // UsersAccountsBalanceSummaryResponseData?
  //     usersAccountsBalanceSummaryResponseData;

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

  // Future<void> getBalanceSummary() async {
  //   UserInfo? userInfo = await applicationController.getUserInfo();
  //   if (userInfo == null || userInfo.user_id == null) {
  //     return;
  //   }
  //   Map<String, dynamic> query = {};
  //   await NetworkUtil.request<UsersAccountsBalanceSummaryResponseData>(
  //       Method.GET,
  //       UrlConfig.users_accounts_balance_summary
  //           .replaceAll(UrlConfig.urlKey, userInfo.user_id!),
  //       query: query, successCallback: (data, baseEntity) async {
  //     if (data != null) {
  //       usersAccountsBalanceSummaryResponseData = data;
  //       if (data.usd_balance != null && data.xcash_balance != null) {
  //         double theUsdBalance = double.tryParse(data.usd_balance!) ?? 0;
  //         double theXcashBalance = double.tryParse(data.xcash_balance!) ?? 0;
  //         amountUsdUnit = theUsdBalance / theXcashBalance;
  //       }
  //     }
  //   }, errorCallback: (e) async {
  //     ToastUtil.showShortToast(e.msg);
  //   });
  //   notifyListeners();
  // }

  Future<void> getTransfers(bool isRefresh) async {
    pullRefreshController.checkResetIndex(isRefresh);
    Map<String, dynamic> query = {};
    query["page"] = pullRefreshController.index;
    query["page_size"] = 100;
    // query["type"] = "all";
    List<Transfer>? transfers = await applicationController.getTransfers(query,coinSymbol == CoinSymbolUtil.coin_symbol_wxcash);
    if (transfers == null) {
      pullRefreshController.stopLoading(true);
      return;
    }
    pullRefreshController.addPage(isRefresh, transfers, transfers.length == 0);
  }

  void jumpToTransferDetailsActivity(Transfer transfer) {
    Bundle bundle = Bundle();
    bundle.putObject(KeyConfig.transfer_key, transfer);
    NavigatorUtil.jumpTo(context, ActivityName.TransferDetailsActivity,
        bundle: bundle);
  }

  Future<void> updateCoinSymbol() async {
    coinSymbol = CoinSymbolUtil.getSelectCoinSymbol();
    await initData(refreshAccount: true);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/utils/network/method.dart';
import 'package:framework/utils/toast_util.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/url_config.dart';
import 'package:x_bank/models/account.dart';
import 'package:x_bank/models/response/users_accounts_balance_summary_response_data.dart';
import 'package:x_bank/models/response/users_transfers_check_response_data.dart';
import 'package:x_bank/models/transfer.dart';
import 'package:x_bank/models/user_info.dart';
import 'package:x_bank/utils/network_util.dart';
import 'package:x_bank/widgets/pull_refresh_view.dart';

import '../extra/application_controller.dart';

class MainActivityFragmentTransferController extends BaseController {
  PullRefreshController pullRefreshController =
      PullRefreshController<Transfer>();

  bool isTransfer = false;
  late ApplicationController applicationController;
  UsersAccountsBalanceSummaryResponseData?
      usersAccountsBalanceSummaryResponseData;
  String? address;
  String? paymentId;
  String? amount;
  UsersTransfersCheckResponseData? usersTransfersCheckResponseData;
  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    postFrameCallback((callback) async {
      await initData();
    });
  }

  void openNewTransfer() {
    isTransfer = true;
    notifyListeners();
  }

  void closeNewTransfer() {
    isTransfer = false;
    notifyListeners();
  }

  Future<void> initData() async {
    await getBalanceSummary();
    await getTransfers(true);
  }

  Future<void> getBalanceSummary() async {
    UserInfo? userInfo = await applicationController.getUserInfo();
    if (userInfo == null || userInfo.user_id == null) {
      return;
    }
    Map<String, dynamic> query = {};
    await NetworkUtil.request<UsersAccountsBalanceSummaryResponseData>(
        Method.GET,
        UrlConfig.users_accounts_balance_summary
            .replaceAll(UrlConfig.urlKey, userInfo.user_id!),
        query: query, successCallback: (data, baseEntity) async {
      if (data != null) {
        usersAccountsBalanceSummaryResponseData = data;
      }
    }, errorCallback: (e) async {
      ToastUtil.showShortToast(e.msg);
    });
    notifyListeners();
  }

  Future<void> getTransfers(bool isRefresh) async {
    pullRefreshController.checkResetIndex(isRefresh);
    Map<String, dynamic> query = {};
    query["page"] = pullRefreshController.index;
    query["page_size"] = 100;
    query["type"] = "out";
    List<Transfer>? transfers = await applicationController.getTransfers(query);
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
    Account? account = await applicationController.getAccount();
    if (userInfo == null ||
        userInfo.user_id == null ||
        account == null ||
        account.id == null) {
      return;
    }
    Map<String, dynamic> data = {};
    data["address"] = address;
    data["payment_id"] = paymentId;
    data["atomic_amount"] = amount;
    data["currency"] = "XCASH";
    baseActivityState.baseDialogController?.show(AppConfig.appS.loading);
    await NetworkUtil.request<UsersTransfersCheckResponseData>(
        Method.POST,
        UrlConfig.users_transfers_check
            .replaceAll(UrlConfig.urlKey, userInfo.user_id!)
            .replaceAll(UrlConfig.urlKey1, account.id!),
        data: data, successCallback: (data, baseEntity) async {
      usersTransfersCheckResponseData=data;
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
    Account? account = await applicationController.getAccount();
    if (userInfo == null ||
        userInfo.user_id == null ||
        account == null ||
        account.id == null) {
      return;
    }
    Map<String, dynamic> data = {};
    data["address"] = address;
    data["payment_id"] = paymentId;
    data["atomic_amount"] = amount;
    data["code_2fa"] = amount;
    data["currency"] = "XCASH";
    baseActivityState.baseDialogController?.show(AppConfig.appS.loading);
    await NetworkUtil.request<UserInfo>(
        Method.POST,
        UrlConfig.users_transfers
            .replaceAll(UrlConfig.urlKey, userInfo.user_id!)
            .replaceAll(UrlConfig.urlKey1, account.id!),
        data: data, successCallback: (data, baseEntity) async {
      String token = data?.access_token ?? "";
      ToastUtil.showShortToast(token);
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

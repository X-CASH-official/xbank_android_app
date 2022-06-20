import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/utils/network/method.dart';
import 'package:framework/utils/toast_util.dart';
import 'package:x_bank/configs/url_config.dart';
import 'package:x_bank/models/response/users_accounts_balance_summary_response_data.dart';
import 'package:x_bank/models/transfer.dart';
import 'package:x_bank/models/user_info.dart';
import 'package:x_bank/utils/network_util.dart';
import 'package:x_bank/widgets/pull_refresh_view.dart';

import '../extra/application_controller.dart';

class MainActivityFragmentHomeController extends BaseController {
  PullRefreshController pullRefreshController =
      PullRefreshController<Transfer>();

  late ApplicationController applicationController;
  UsersAccountsBalanceSummaryResponseData?
      usersAccountsBalanceSummaryResponseData;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    postFrameCallback((callback) async {
      await initData();
    });
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
    // query["type"] = "all";
    List<Transfer>? transfers = await applicationController.getTransfers(query);
    if (transfers == null) {
      pullRefreshController.stopLoading(true);
      return;
    }
    pullRefreshController.addPage(isRefresh, transfers, transfers.length == 0);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

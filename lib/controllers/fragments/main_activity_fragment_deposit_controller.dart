import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/utils/toast_util.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/models/account.dart';
import 'package:x_bank/utils/clipboard_util.dart';

import '../extra/application_controller.dart';

class MainActivityFragmentDepositController extends BaseController {
  late ApplicationController applicationController;
  final ScrollController scrollController = ScrollController();

  String? address;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    postFrameCallback((callback) async {
      await initData();
    });
  }

  Future<void> initData() async {
    Account? account = await applicationController.getAccount();
    if (account != null) {
      address = account.integrated_address;
    }
    notifyListeners();
  }

  void copyAddressToClipboard() {
    if (address == null) {
      return;
    }
    ToastUtil.showShortToast(
        AppConfig.appS.main_activity_fragment_deposit_copy_success_tips);
    ClipboardUtil.setData(address!);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

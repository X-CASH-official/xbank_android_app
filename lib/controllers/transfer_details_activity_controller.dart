import 'package:flutter/cupertino.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/configs/key_config.dart';
import 'package:x_bank/models/transfer.dart';

import 'extra/application_controller.dart';

class TransferDetailsActivityController extends BaseController {
  late ApplicationController applicationController;
  Transfer? transfer;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    transfer = bundle?.getObject(KeyConfig.transfer_key);
    postFrameCallback((callback) async {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}

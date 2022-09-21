import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/configs/router_config.dart';
import 'package:x_bank/utils/navigator_util.dart';

import 'extra/application_controller.dart';

class SplashActivityController extends BaseController {
  late ApplicationController applicationController;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    postFrameCallback((callback) async {
      await AppConfig.initApplication();
      await Future.delayed(Duration(milliseconds: 2000));
      goToJump();
    });
  }

  void goToJump() async {
    if (applicationController.getToken() != null) {
      await applicationController.getAccounts(refresh: true);
      NavigatorUtil.replaceTo(context, ActivityName.MainActivity);
    } else {
      NavigatorUtil.replaceTo(context, ActivityName.LoginActivity);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

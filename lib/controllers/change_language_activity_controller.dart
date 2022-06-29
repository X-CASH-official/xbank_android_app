import 'package:flutter/cupertino.dart';
import 'package:framework/base/activity_manager.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/utils/eventbus_manager.dart';
import 'package:x_bank/activitys/main_activity.dart';
import 'package:x_bank/configs/event_config.dart';
import 'package:x_bank/utils/language_util.dart';

import 'extra/application_controller.dart';
import 'main_activity_controller.dart';

class ChangeLanguageActivityController extends BaseController {
  late ApplicationController applicationController;
  String? oldPassword;
  String? password;
  String? confirmPassword;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    postFrameCallback((callback) async {});
  }

  Future<void> updateLanguage(int index) async {
    String language = "en";
    switch (index) {
      case 0:
        language = "en";
        break;
      case 1:
        language = "zh";
        break;
      default:
        break;
    }
    Locale locale = LanguageUtil.getLanguageLocale(language);
    if (locale.languageCode ==
        LanguageUtil.getSelectLanguageLocale().languageCode) {
      return;
    }
    await LanguageUtil.updateSelectLanguageLocale(locale);
    EventBusManager().send(EventConfig.event_update_locale, locale);
    postFrameCallback((callback) async {
      await Future.delayed(
          Duration(milliseconds: 100)); //Update system locale need some time
      (ActivityManager().getTargetActivity<MainActivityState>()?.baseController
              as MainActivityController)
          .updateLanguage();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:framework/base/activity_manager.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/utils/eventbus_manager.dart';
import 'package:x_bank/activitys/main_activity.dart';
import 'package:x_bank/configs/event_config.dart';
import 'package:x_bank/utils/coin_symbol_util.dart';

import 'extra/application_controller.dart';
import 'main_activity_controller.dart';

class SwitchCoinActivityController extends BaseController {
  late ApplicationController applicationController;

  int selectIndex = 0;
  String? coinSymbol;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    updateCoinSymbol();
    postFrameCallback((callback) async {});
  }

  Future<void> selectCoinSymbol(int index) async {
    String newCoinSymbol = CoinSymbolUtil.coin_symbol_xcash;
    switch (index) {
      case 0:
        newCoinSymbol = CoinSymbolUtil.coin_symbol_xcash;
        break;
      case 1:
        newCoinSymbol = CoinSymbolUtil.coin_symbol_wxcash;
        break;
      default:
        break;
    }
    String theCoinSymbol = CoinSymbolUtil.getSelectCoinSymbol();
    if (newCoinSymbol == theCoinSymbol) {
      return;
    }
    await CoinSymbolUtil.updateSelectCoinSymbol(newCoinSymbol);
    EventBusManager().send(EventConfig.event_update_coin_symbol, coinSymbol);
    await updateCoinSymbol();
    postFrameCallback((callback) async {
      await Future.delayed(
          Duration(milliseconds: 100)); //Update system locale need some time
      (ActivityManager().getTargetActivity<MainActivityState>()?.baseController
              as MainActivityController)
          .updateCoinSymbol();
      notifyListeners();
    });
  }

  Future<void> updateCoinSymbol() async {
    coinSymbol = CoinSymbolUtil.getSelectCoinSymbol();
    switch (coinSymbol) {
      case CoinSymbolUtil.coin_symbol_xcash:
        selectIndex = 0;
        break;
      case CoinSymbolUtil.coin_symbol_wxcash:
        selectIndex = 1;
        break;
      default:
        break;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

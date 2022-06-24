import 'package:flutter/material.dart';
import 'package:framework/base/bundle.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:x_bank/configs/key_config.dart';
import 'package:x_bank/widgets/js_bridge/js_bridge_view.dart';
import 'extra/application_controller.dart';

class WebViewActivityController extends BaseController {
  final GlobalKey<JsBridgeViewState> jsBridgeViewStateKey =
      GlobalKey<JsBridgeViewState>();
  late ApplicationController applicationController;
  String? title;
  String? url;
  bool isInitSuccess = false;
  int lineProgress = 0;
  AnimationController? animationController;

  @override
  void initController(State state, Bundle? bundle) {
    applicationController = ApplicationController.getInstance();
    title = bundle?.getString(KeyConfig.web_view_title_key);
    url = bundle?.getString(KeyConfig.web_view_url_key);
    postFrameCallback((callback) async {});
  }

  void processJsBridgeEvent(JsBridgeEvent jsBridgeEvent, bool isSuccess,
      String? messageKey, dynamic data) {
    if (jsBridgeEvent == JsBridgeEvent.ON_WEB_VIEW_CREATED) {
      initWebView();
    }
  }

  void initWebView() {}

  void updateProgress(int value) {
    this.lineProgress = value;
    notifyListeners();
  }

  void doRefresh() {
    isInitSuccess = false;
    jsBridgeViewStateKey.currentState?.reload();
    animationController?.reset();
    animationController?.forward();
  }

  Future<bool> doBack() async {
    bool canBack =
        await jsBridgeViewStateKey.currentState?.canGoBack() ?? false;
    if (canBack) {
      jsBridgeViewStateKey.currentState?.goBack();
    } else {
      baseActivityState.finish();
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

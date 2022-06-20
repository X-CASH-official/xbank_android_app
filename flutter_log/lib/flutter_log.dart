import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterLog {
  static const String _tag = "NativeLog";

  static const MethodChannel _channel = const MethodChannel('flutter_log');

  static void d(String message, {String tag = _tag}) {
    if (kIsWeb == true ? false : Platform.isAndroid) {
      _channel.invokeMethod("logD", {"tag": tag, "msg": message});
    }
  }

  static void e(String message, {String tag = _tag}) {
    if (kIsWeb == true ? false : Platform.isAndroid) {
      _channel.invokeMethod("logE", {"tag": tag, "msg": message});
    }
  }
}

import 'package:flutter/services.dart';

class ClipboardUtil {
  static setData(String data) {
    if (data != null && data != "") {
      Clipboard.setData(ClipboardData(text: data));
    }
  }

  static Future getData() {
    return Clipboard.getData(Clipboard.kTextPlain);
  }
}

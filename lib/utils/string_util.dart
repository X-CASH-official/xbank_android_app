import 'package:intl/intl.dart';

class StringUtil {
  static bool isChinaPhoneLegal(String str) {
    return RegExp(
            r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$')
        .hasMatch(str);
  }

  static bool compareLowerCaseValue(String? value1, String? value2) {
    if (value1 == null || value2 == null) {
      return false;
    }
    if (value1.toLowerCase() == value2.toLowerCase()) {
      return true;
    }
    return false;
  }

  static bool containsLowerCaseValue(String? value1, String? value2) {
    if (value1 == null || value2 == null) {
      return false;
    }
    if (value1.toLowerCase().contains(value2.toLowerCase())) {
      return true;
    }
    return false;
  }

  static String convertUtcTime(String time) {
    try {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      DateTime dateTime = DateTime.parse(time);
      return dateFormat.format(dateTime);
    } catch (e) {
      return "";
    }
  }

  static String convertToHiddenContent(String content) {
    int length = content.length;
    String newAssets = "";
    for (int i = 0; i < length; i++) {
      newAssets = newAssets + "*";
    }
    return newAssets;
  }
}

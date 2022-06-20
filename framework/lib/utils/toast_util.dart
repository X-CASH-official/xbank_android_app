/**
 * @author snakeway
 * @description:
 * @date :2021/3/23
 */
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static showToast(String? content,
      {Toast toastLength = Toast.LENGTH_SHORT,
      ToastGravity gravity = ToastGravity.BOTTOM,
      int timeInSecForIosWeb = 1,
      Color backgroundColor = Colors.black54,
      Color textColor = Colors.white}) {
    Fluttertoast.showToast(
      msg: content ?? "",
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }


  static showShortToast(String? content) {
    if(content==null||content==""){
      return;
    }
    showToast(content, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
  }

  static showLongToast(String? content) {
    if(content==null||content==""){
      return;
    }
    showToast(content, toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
  }
}

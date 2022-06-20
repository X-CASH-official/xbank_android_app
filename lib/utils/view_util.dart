import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:framework/base/base_callback_function.dart';
import 'package:framework/utils/screen_util.dart';
import 'package:x_bank/activitys/views/popup_2fa_input_view.dart';
import 'package:x_bank/configs/assets_config.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_popup_route.dart';
import 'package:x_bank/widgets/normal/normal_popup_view.dart';

import 'keyboard_util.dart';
import 'navigator_util.dart';

class ViewUtil {
  static PlaceholderWidgetBuilder getDefaultPlaceholder(BuildContext context,
      {double? width, double? height}) {
    return (context, url) {
      bool isOverWidth = false;
      bool isOverHeight = false;
      if (width != null) {
        if (width! < Dimens.image_placeholder_width) {
          isOverWidth = true;
        }
      } else {
        width = Dimens.image_placeholder_width;
      }
      if (height != null) {
        if (height! < Dimens.image_placeholder_height) {
          isOverHeight = true;
        }
      } else {
        height = Dimens.image_placeholder_height;
      }
      if (!isOverWidth && !isOverHeight) {
        width = Dimens.image_placeholder_width;
        height = Dimens.image_placeholder_height;
      }
      return UnconstrainedBox(
        child: Container(
          width: width,
          height: height,
          child: Image.asset(
            AssetImageConfig.normal_loading,
            width: width,
            height: height,
            fit: BoxFit.contain,
          ),
        ),
      );
    };
  }

  static LoadingErrorWidgetBuilder getDefaultLoadingErrorWidgetBuilder(
      BuildContext context,
      {double? width,
      double? height}) {
    return (BuildContext context, String url, dynamic error) {
      bool isOverWidth = false;
      bool isOverHeight = false;
      if (width != null) {
        if (width! < Dimens.image_placeholder_width) {
          isOverWidth = true;
        }
      } else {
        width = Dimens.image_placeholder_width;
      }
      if (height != null) {
        if (height! < Dimens.image_placeholder_height) {
          isOverHeight = true;
        }
      } else {
        height = Dimens.image_placeholder_height;
      }
      if (!isOverWidth && !isOverHeight) {
        width = Dimens.image_placeholder_width;
        height = Dimens.image_placeholder_height;
      }
      return UnconstrainedBox(
        child: Container(
          width: width,
          height: height,
          child: Image.asset(
            AssetImageConfig.normal_loading_error,
            width: width,
            height: height,
            fit: BoxFit.contain,
          ),
        ),
      );
    };
  }

  static Widget getDefaultLine() {
    return Divider(height: Dimens.line_narrow, color: SColors.line);
  }

  static Future<void> showBottomSheetView(
      BuildContext context, WidgetBuilder builder,
      {bool isScrollControlled = true,
      Color? backgroundColor,
      ShapeBorder? shape}) async {
    KeyBoardUtil.hideKeyboard(context);
    await showModalBottomSheet<bool>(
        context: context,
        builder: builder,
        clipBehavior: Clip.none,
        isScrollControlled: isScrollControlled,
        backgroundColor: backgroundColor,
        shape: shape);
  }

  static void showPopup2faInputViewDialog<T>(BuildContext context,
      VoidStringCallback? onTextChange, VoidCallback? onSubmitClick,
      {BoxDecoration? decoration,
      Color background = Colors.white,
      bool releaseFocus = true}) {
    if (releaseFocus) {
      KeyBoardUtil.hideKeyboard(context);
    }
    double maxWidth = min(ScreenUtil.width, ScreenUtil.height);
    double viewWidth = maxWidth * 0.8;
    double marginLeft = maxWidth * 0.1;
    Widget contentView = NormalPopupView(
      left: marginLeft,
      top: 0,
      bottom: 0,
      child: Container(
        width: viewWidth,
        child: Popup2faInputView(
            onTextChange: onTextChange,
            onSubmitClick: () {
              NavigatorUtil.pop(context, NavigatorResultType.SUCCESS);
              onSubmitClick?.call();
            }),
      ),
    );
    Navigator.push(
      context,
      NormalPopupRoute(
        child: contentView,
      ),
    );
  }
}

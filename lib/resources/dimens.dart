import 'package:flutter/widgets.dart';
import 'package:framework/utils/screen_util.dart';

class Dimens {
  static double s_target_width = 375;

  static double get target_width {
    return ScreenUtil.getSize(s_target_width);
  }

  static double get loading_dialog_width {
    return ScreenUtil.getSize(94);
  }

  static double get loading_dialog_height {
    return ScreenUtil.getSize(94);
  }

  static double get loading_dialog_indicator_width {
    return ScreenUtil.getSize(34);
  }

  static double get loading_dialog_indicator_half_width {
    return ScreenUtil.getSize(17);
  }

  static double get loading_dialog_radius {
    return ScreenUtil.getSize(6);
  }

  static double get margin_super_narrow {
    return ScreenUtil.getSize(4);
  }

  static double get margin_narrow {
    return ScreenUtil.getSize(8);
  }

  static double get margin_normal {
    return ScreenUtil.getSize(12);
  }

  static double get margin_broad {
    return ScreenUtil.getSize(16);
  }

  static double get margin_super_broad {
    return ScreenUtil.getSize(20);
  }

  static double get no_data_image_width {
    return ScreenUtil.getSize(166);
  }

  static double get no_data_image_height {
    return ScreenUtil.getSize(112);
  }

  static double get button_width_narrow {
    return ScreenUtil.getSize(50);
  }

  static double get button_width_normal {
    return ScreenUtil.getSize(100);
  }

  static double get button_width_board {
    return ScreenUtil.getSize(150);
  }

  static double get button_height_narrow {
    return ScreenUtil.getSize(30);
  }

  static double get button_height_normal {
    return ScreenUtil.getSize(35);
  }

  static double get button_height_board {
    return ScreenUtil.getSize(40);
  }

  static double get radius_super_narrow {
    return ScreenUtil.getSize(2);
  }

  static double get radius_narrow {
    return ScreenUtil.getSize(4);
  }

  static double get radius_normal {
    return ScreenUtil.getSize(6);
  }

  static double get radius_broad {
    return ScreenUtil.getSize(8);
  }

  static double get radius_super_broad {
    return ScreenUtil.getSize(10);
  }

  static double get line_narrow {
    return ScreenUtil.getSize(0.5, sizeType: SizeType.UnDo);
  }

  static double get line_normal {
    return ScreenUtil.getSize(1);
  }

  static double get line_broad {
    return ScreenUtil.getSize(2);
  }

  static double get font_min_narrow {
    return ScreenUtil.getSize(6);
  }

  static double get font_super_narrow {
    return ScreenUtil.getSize(8);
  }

  static double get font_more_narrow {
    return ScreenUtil.getSize(10);
  }

  static double get font_narrow {
    return ScreenUtil.getSize(12);
  }

  static double get font_normal {
    return ScreenUtil.getSize(14);
  }

  static double get font_broad {
    return ScreenUtil.getSize(16);
  }

  static double get font_more_broad {
    return ScreenUtil.getSize(18);
  }

  static double get font_super_broad {
    return ScreenUtil.getSize(20);
  }

  static double get font_max_broad {
    return ScreenUtil.getSize(22);
  }

  static double get ponit_view_width_narrow {
    return ScreenUtil.getSize(3);
  }

  static double get ponit_view_width_normal {
    return ScreenUtil.getSize(6);
  }

  static double get ponit_view_width_broad {
    return ScreenUtil.getSize(9);
  }

  static double get normal_search_view_height {
    return ScreenUtil.getSize(32);
  }

  static double get normal_tab_view_height {
    return ScreenUtil.getSize(32);
  }

  static double get normal_toolbar_height {
    return ScreenUtil.getSize(32);
  }

  static double get image_placeholder_width {
    return ScreenUtil.getSize(40);
  }

  static double get image_placeholder_height {
    return ScreenUtil.getSize(40);
  }

  static double get version_update_view_progress_height {
    return ScreenUtil.getSize(6);
  }

  static double get splash_activity_icon_width {
    return ScreenUtil.getSize(75);
  }

  static double get login_activity_top_background_width {
    return ScreenUtil.getSize(200);
  }

  static double get login_activity_top_background_margin_top {
    return ScreenUtil.getSize(30);
  }

  static double get bottom_navigation_bar_height {
    return ScreenUtil.getSize(50);
  }

  static double get main_activity_tab_item_space_height {
    return ScreenUtil.getSize(3);
  }

  static double get main_activity_fragment_settings_user_avatar_width {
    return ScreenUtil.getSize(55);
  }

  static double get webview_menu_icon_width {
    return ScreenUtil.getSize(21);
  }
}

class DimenBoxs {
  static Widget get hBox2 {
    return Container(width: ScreenUtil.getSize(2));
  }

  static Widget get hBox4 {
    return Container(width: ScreenUtil.getSize(4));
  }

  static Widget get hBox6 {
    return Container(width: ScreenUtil.getSize(6));
  }

  static Widget get hBox8 {
    return Container(width: ScreenUtil.getSize(8));
  }

  static Widget get hBox10 {
    return Container(width: ScreenUtil.getSize(10));
  }

  static Widget get hBox12 {
    return Container(width: ScreenUtil.getSize(12));
  }

  static Widget get hBox14 {
    return Container(width: ScreenUtil.getSize(14));
  }

  static Widget get hBox16 {
    return Container(width: ScreenUtil.getSize(16));
  }

  static Widget get hBox18 {
    return Container(width: ScreenUtil.getSize(18));
  }

  static Widget get hBox20 {
    return Container(width: ScreenUtil.getSize(20));
  }

  static Widget get hBox22 {
    return Container(width: ScreenUtil.getSize(22));
  }

  static Widget get hBox24 {
    return Container(width: ScreenUtil.getSize(24));
  }

  static Widget get hBox26 {
    return Container(width: ScreenUtil.getSize(26));
  }

  static Widget get hBox28 {
    return Container(width: ScreenUtil.getSize(28));
  }

  static Widget get hBox30 {
    return Container(width: ScreenUtil.getSize(30));
  }

  static Widget get vBox2 {
    return Container(height: ScreenUtil.getSize(2));
  }

  static Widget get vBox4 {
    return Container(height: ScreenUtil.getSize(4));
  }

  static Widget get vBox6 {
    return Container(height: ScreenUtil.getSize(6));
  }

  static Widget get vBox8 {
    return Container(height: ScreenUtil.getSize(8));
  }

  static Widget get vBox10 {
    return Container(height: ScreenUtil.getSize(10));
  }

  static Widget get vBox12 {
    return Container(height: ScreenUtil.getSize(12));
  }

  static Widget get vBox14 {
    return Container(height: ScreenUtil.getSize(14));
  }

  static Widget get vBox16 {
    return Container(height: ScreenUtil.getSize(16));
  }

  static Widget get vBox18 {
    return Container(height: ScreenUtil.getSize(18));
  }

  static Widget get vBox20 {
    return Container(height: ScreenUtil.getSize(20));
  }

  static Widget get vBox22 {
    return Container(height: ScreenUtil.getSize(22));
  }

  static Widget get vBox24 {
    return Container(height: ScreenUtil.getSize(24));
  }

  static Widget get vBox26 {
    return Container(height: ScreenUtil.getSize(26));
  }

  static Widget get vBox28 {
    return Container(height: ScreenUtil.getSize(28));
  }

  static Widget get vBox30 {
    return Container(height: ScreenUtil.getSize(30));
  }

  static Widget get hBoxSuperNarrow {
    return Container(width: ScreenUtil.getSize(4));
  }

  static Widget get hBoxNarrow {
    return Container(width: ScreenUtil.getSize(8));
  }

  static Widget get hBoxNormal {
    return Container(width: ScreenUtil.getSize(12));
  }

  static Widget get hBoxBroad {
    return Container(width: ScreenUtil.getSize(16));
  }

  static Widget get hBoxSuperBroad {
    return Container(width: ScreenUtil.getSize(20));
  }

  static Widget get vBoxSuperNarrow {
    return Container(height: ScreenUtil.getSize(4));
  }

  static Widget get vBoxNarrow {
    return Container(height: ScreenUtil.getSize(8));
  }

  static Widget get vBoxNormal {
    return Container(height: ScreenUtil.getSize(12));
  }

  static Widget get vBoxBroad {
    return Container(height: ScreenUtil.getSize(16));
  }

  static Widget get vBoxSuperBroad {
    return Container(height: ScreenUtil.getSize(20));
  }
}

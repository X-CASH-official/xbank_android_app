import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:framework/base/base_activity.dart';
import 'package:framework/base/controllers/base_controller.dart';
import 'package:framework/extension/widget_extension.dart';
import 'package:x_bank/controllers/main_activity_controller.dart';
import 'package:x_bank/models/extra/tab_item.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/bottom_tab_view.dart';
import 'package:x_bank/widgets/normal/normal_image_view.dart';

import 'new_base_activity.dart';

class MainActivity extends NewBaseActivity {
  MainActivity(bundle) : super(bundle: bundle);

  @override
  BaseActivityState getState() => MainActivityState();
}

class MainActivityState extends NewBaseActivityState<MainActivity> {
  MainActivityController _controller = MainActivityController();

  @override
  BaseController initController() {
    return _controller;
  }

  @override
  Widget buildViews(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        key: _controller.scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: _buildBodyView(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ).addBackIntercept(_controller.exitApp),
    );
  }

  Widget _buildBottomNavigationBar() {
    List<Widget> views = [];
    for (int i = 0; i < _controller.tabItems.length; i++) {
      views.add(_getTabItem(i));
    }
    Widget contentView = Container(
      height: Dimens.bottom_navigation_bar_height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: views,
          )
        ],
      ),
    );
    return BottomAppBar(
      color: SColors.main_help,
      child: contentView,
    );
  }

  Widget _getTabItem(int index) {
    bool isSelect = false;
    if (index == _controller.currentIndex) {
      isSelect = true;
    }
    TabItem tabItem = _controller.tabItems[index];
    Widget contentView = BottomTabView(
      imageIcon: NormalImageView(
        assetUrl: tabItem.icon,
        width: Dimens.font_broad,
        color: isSelect ? tabItem.iconSelect : tabItem.iconUnSelect,
      ),
      space: Dimens.main_activity_tab_item_space_height,
      title: tabItem.name,
      color: isSelect ? tabItem.iconSelect : tabItem.iconUnSelect,
      titleSize: Dimens.font_narrow,
      onClick: () {
        _controller.updateIndex(index);
      },
    );
    return Expanded(
      child: contentView,
      flex: 1,
    );
  }

  Widget _buildBodyView() {
    _controller.refreshFragments();
    return IndexedStack(
      children: _controller.fragments,
      index: _controller.currentIndex,
    );
  }
}

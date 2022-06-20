import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:framework/base/base_callback_function.dart';
import 'package:framework/extension/widget_extension.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';

import 'normal_icon_view.dart';
import 'normal_text_view.dart';

class NormalToolbarView extends StatelessWidget {
  final double? toolbarHeight;
  final SystemUiOverlayStyle systemUiOverlayStyle;
  final Color contentColor;
  final Color toolbarBackgroundColor;
  final Color backgroundColor;
  final Color bodyColor;
  final bool showBack;
  final bool showLeftTitle;
  final bool showCenterTitle;
  final bool showLeadingView;
  final bool showActionView;
  final bool showActionIcon;
  final bool canScroll;
  final bool addBackIntercept;
  final bool resizeToAvoidBottomPadding;
  final bool showBottomLine;
  final bool onlyShowAppbar;
  final String? title;
  final int? backIcon;
  final int? actionIcon;
  final double? fontSize;
  final double? iconSize;
  final double? iconMarginSpace;
  final double? iconPaddingSpace;
  final Widget? leading;
  final Widget? middle;
  final Widget? actions;
  final Widget? bottomNavigationBar;
  final Widget? body;
  final int leadingFlex;
  final int middleFlex;
  final int actionFlex;
  final BoolFutureCallback? onBackIntercept;
  final VoidCallback? onBackClick;
  final VoidCallback? onActionClick;

  const NormalToolbarView(
      {Key? key,
      this.toolbarHeight,
      this.systemUiOverlayStyle = SystemUiOverlayStyle.dark,
      this.contentColor = SColors.text_title,
      this.toolbarBackgroundColor = Colors.transparent,
      this.backgroundColor = Colors.transparent,
      this.bodyColor = Colors.transparent,
      this.showBack = true,
      this.showLeftTitle = false,
      this.showCenterTitle = false,
      this.showLeadingView = true,
      this.showActionView = true,
      this.showActionIcon = false,
      this.canScroll = true,
      this.addBackIntercept = false,
      this.resizeToAvoidBottomPadding = true,
      this.showBottomLine = false,
      this.onlyShowAppbar = false,
      this.title,
      this.backIcon,
      this.actionIcon,
      this.fontSize,
      this.iconSize,
      this.iconMarginSpace,
      this.iconPaddingSpace,
      this.leading,
      this.middle,
      this.actions,
      this.bottomNavigationBar,
      this.body,
      this.leadingFlex = 1,
      this.middleFlex = 1,
      this.actionFlex = 1,
      this.onBackIntercept,
      this.onBackClick,
      this.onActionClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomPadding,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        top: true,
        child: _buildBodyView(),
      ),
    );
    if (addBackIntercept) {
      scaffold.addBackIntercept(() {
        if (onBackIntercept != null) {
          return onBackIntercept!.call();
        } else {
          return Future.value(true);
        }
      });
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: onlyShowAppbar
          ? SafeArea(
              top: true,
              child: _buildAppbar(),
            )
          : scaffold,
    );
  }

  Widget _buildBodyView() {
    return Container(
      //margin: EdgeInsets.symmetric(vertical: Dimens.line_narrow),
      //Fix the listview line height change problem
      child: Column(
        children: [
          _buildAppbar(),
          body != null
              ? Expanded(
                  child: Container(
                    color: bodyColor,
                    child: body,
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _buildAppbar() {
    double theToolbarHeight = toolbarHeight ?? Dimens.normal_toolbar_height;
    double theFontSize = fontSize ?? Dimens.font_broad;
    double theIconSize = iconSize ?? Dimens.font_broad;
    double theIconMarginSpace = iconMarginSpace ?? Dimens.margin_narrow;
    double theIconPaddingSpace = iconPaddingSpace ?? Dimens.margin_super_narrow;
    Widget contentView = Row(
      children: [
        showLeadingView
            ? _buildLeadingContentView(theFontSize, theIconSize,
                theIconMarginSpace, theIconPaddingSpace)
            : Container(),
        middle != null || showCenterTitle
            ? Expanded(
                flex: middleFlex,
                child: _buildMiddleView(theFontSize, theIconSize),
              )
            : Container(),
        showActionView
            ? _buildActionContentView(theFontSize, theIconSize,
                theIconMarginSpace, theIconPaddingSpace)
            : Container(),
      ],
    );
    return Container(
      height: theToolbarHeight,
      decoration: BoxDecoration(
        color: toolbarBackgroundColor,
        border: Border(
          bottom: showBottomLine
              ? BorderSide(width: Dimens.line_narrow, color: SColors.line)
              : BorderSide.none,
        ),
      ),
      child: contentView,
    );
  }

  Widget _buildLeadingContentView(double fontSize, double iconSize,
      double iconMarginSpace, double iconPaddingSpace) {
    return Expanded(
      flex: leadingFlex,
      child: canScroll
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildLeadingView(
                  fontSize, iconSize, iconMarginSpace, iconPaddingSpace),
            )
          : _buildLeadingView(
              fontSize, iconSize, iconMarginSpace, iconPaddingSpace),
    );
  }

  Widget _buildActionContentView(double fontSize, double iconSize,
      double iconMarginSpace, double iconPaddingSpace) {
    return Expanded(
      flex: actionFlex,
      child: canScroll
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: _buildActionsView(
                  fontSize, iconSize, iconMarginSpace, iconPaddingSpace),
            )
          : _buildActionsView(
              fontSize, iconSize, iconMarginSpace, iconPaddingSpace),
    );
  }

  Widget _buildLeadingView(double fontSize, double iconSize,
      double iconMarginSpace, double iconPaddingSpace) {
    Widget contentView = Row(
      children: [
        _buildBackView(fontSize, iconSize, iconMarginSpace, iconPaddingSpace),
        canScroll
            ? _buildLeftTitleView(fontSize, iconSize)
            : Expanded(child: _buildLeftTitleView(fontSize, iconSize))
      ],
    );
    return leading ??
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: contentView,
          onTap: onBackClick,
        );
  }

  Widget _buildBackView(double fontSize, double iconSize,
      double iconMarginSpace, double iconPaddingSpace) {
    IconData? theIconBack =
        backIcon == null ? Icons.arrow_back_ios_sharp : null;
    Widget contentView = NormalIconView(
      icon: backIcon ?? -1,
      iconData: theIconBack,
      fontSize: iconSize,
      margin: EdgeInsets.only(left: iconMarginSpace),
      padding: EdgeInsets.all(iconPaddingSpace),
      color: contentColor,
    );
    return showBack ? contentView : Container();
  }

  Widget _buildLeftTitleView(double fontSize, double iconSize) {
    return showLeftTitle
        ? Container(
            child: NormalTextView(
              content: title,
              color: contentColor,
              fontSize: fontSize,
            ),
          )
        : Container();
  }

  Widget _buildMiddleView(double fontSize, double iconSize) {
    return middle ?? _buildCenterTitleView(fontSize, iconSize);
  }

  Widget _buildCenterTitleView(double fontSize, double iconSize) {
    return showCenterTitle
        ? Container(
            alignment: Alignment.center,
            child: NormalTextView(
                content: title,
                alignment: Alignment.center,
                fontSize: fontSize,
                color: contentColor),
          )
        : Container();
  }

  Widget _buildActionsView(double fontSize, double iconSize,
      double iconMarginSpace, double iconPaddingSpace) {
    return actions ??
        _buildActionIconView(
            fontSize, iconSize, iconMarginSpace, iconPaddingSpace);
  }

  Widget _buildActionIconView(double fontSize, double iconSize,
      double iconMarginSpace, double iconPaddingSpace) {
    IconData? theIconBack = actionIcon == null ? Icons.more_vert_rounded : null;
    Widget contentView = NormalIconView(
        icon: actionIcon ?? -1,
        iconData: theIconBack,
        fontSize: iconSize,
        margin: EdgeInsets.only(right: iconMarginSpace),
        padding: EdgeInsets.all(iconPaddingSpace),
        color: contentColor,
        onClick: () {
          onActionClick?.call();
        });
    return showActionIcon ? contentView : Container();
  }
}

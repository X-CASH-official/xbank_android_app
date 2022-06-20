import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/base/base_callback_function.dart';
import 'package:x_bank/configs/app_config.dart';
import 'package:x_bank/resources/dimens.dart';
import 'package:x_bank/resources/s_colors.dart';
import 'package:x_bank/widgets/normal/normal_button_view.dart';
import 'package:x_bank/widgets/normal/normal_text_view.dart';

import 'normal_loading_input_view.dart';

class Popup2faInputView extends StatelessWidget {
  VoidStringCallback? onTextChange;
  VoidCallback? onSubmitClick;

  Popup2faInputView({Key? key, this.onTextChange, this.onSubmitClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildContentView(),
      ],
    );
  }

  Widget _buildContentView() {
    return Container(
      margin: EdgeInsets.all(Dimens.margin_broad),
      padding: EdgeInsets.all(Dimens.margin_normal),
      decoration: BoxDecoration(
        color: SColors.main_help,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.radius_normal),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopView(),
          DimenBoxs.vBoxNarrow,
          _buildInputView(),
          DimenBoxs.vBoxBroad,
          _buildBottomView()
        ],
      ),
    );
  }

  Widget _buildTopView() {
    return NormalTextView(
      margin: EdgeInsets.symmetric(vertical: Dimens.margin_normal),
      content: AppConfig.appS.validate_2fa,
      color: SColors.text_title,
      fontSize: Dimens.font_broad,
    );
  }

  Widget _buildInputView() {
    return NormalLoadingInputView(
      fontSize: Dimens.font_normal,
      hintText: AppConfig.appS.input_2FA_code_hint,
      padding: EdgeInsets.all(Dimens.margin_narrow),
      onTextChange: onTextChange,
    );
  }

  Widget _buildBottomView() {
    return NormalButtonView(
      text: AppConfig.appS.submit,
      showStroke: false,
      color: SColors.primary,
      radius: Dimens.radius_narrow,
      fontSize: Dimens.font_narrow,
      textColor: SColors.main_help,
      height: Dimens.button_height_narrow,
      onClick: onSubmitClick,
    );
  }
}

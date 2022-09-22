// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `x-bank`
  String get app_name {
    return Intl.message(
      'x-bank',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Processing...`
  String get processing {
    return Intl.message(
      'Processing...',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Server error`
  String get server_error {
    return Intl.message(
      'Server error',
      name: 'server_error',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Click again to exit`
  String get exit_tips {
    return Intl.message(
      'Click again to exit',
      name: 'exit_tips',
      desc: '',
      args: [],
    );
  }

  /// `XCASH`
  String get xcash_unit_text {
    return Intl.message(
      'XCASH',
      name: 'xcash_unit_text',
      desc: '',
      args: [],
    );
  }

  /// `WXCASH`
  String get wxcash_unit_text {
    return Intl.message(
      'WXCASH',
      name: 'wxcash_unit_text',
      desc: '',
      args: [],
    );
  }

  /// `Copy success`
  String get copy_success {
    return Intl.message(
      'Copy success',
      name: 'copy_success',
      desc: '',
      args: [],
    );
  }

  /// `USD`
  String get usd_unit_text {
    return Intl.message(
      'USD',
      name: 'usd_unit_text',
      desc: '',
      args: [],
    );
  }

  /// `Account error`
  String get account_error_tips {
    return Intl.message(
      'Account error',
      name: 'account_error_tips',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login_activity_login_title {
    return Intl.message(
      'Login',
      name: 'login_activity_login_title',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login_activity_login_text {
    return Intl.message(
      'Login',
      name: 'login_activity_login_text',
      desc: '',
      args: [],
    );
  }

  /// `Please input account`
  String get login_activity_account_hint {
    return Intl.message(
      'Please input account',
      name: 'login_activity_account_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please input password`
  String get login_activity_password_hint {
    return Intl.message(
      'Please input password',
      name: 'login_activity_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Account and password can't empty`
  String get login_activity_account_or_password_empty_tips {
    return Intl.message(
      'Account and password can\'t empty',
      name: 'login_activity_account_or_password_empty_tips',
      desc: '',
      args: [],
    );
  }

  /// `I don't have an account.I want to register`
  String get login_activity_register_text {
    return Intl.message(
      'I don\'t have an account.I want to register',
      name: 'login_activity_register_text',
      desc: '',
      args: [],
    );
  }

  /// `Enter your 2FA code`
  String get login_activity_login_2fa_title {
    return Intl.message(
      'Enter your 2FA code',
      name: 'login_activity_login_2fa_title',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register_activity_register_title {
    return Intl.message(
      'Register',
      name: 'register_activity_register_title',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register_activity_register_text {
    return Intl.message(
      'Register',
      name: 'register_activity_register_text',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get register_activity_first_name_hint {
    return Intl.message(
      'First Name',
      name: 'register_activity_first_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get register_activity_last_name_hint {
    return Intl.message(
      'Last Name',
      name: 'register_activity_last_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get register_activity_email_hint {
    return Intl.message(
      'Email',
      name: 'register_activity_email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get register_activity_password_hint {
    return Intl.message(
      'Password',
      name: 'register_activity_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get register_activity_confirm_password_hint {
    return Intl.message(
      'Confirm Password',
      name: 'register_activity_confirm_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Referral ID`
  String get register_activity_referral_id_hint {
    return Intl.message(
      'Referral ID',
      name: 'register_activity_referral_id_hint',
      desc: '',
      args: [],
    );
  }

  /// `Params empty`
  String get register_activity_params_empty_tips {
    return Intl.message(
      'Params empty',
      name: 'register_activity_params_empty_tips',
      desc: '',
      args: [],
    );
  }

  /// `Password not same`
  String get register_activity_password_not_same_tips {
    return Intl.message(
      'Password not same',
      name: 'register_activity_password_not_same_tips',
      desc: '',
      args: [],
    );
  }

  /// `I have an account.I want to login`
  String get register_activity_login_text {
    return Intl.message(
      'I have an account.I want to login',
      name: 'register_activity_login_text',
      desc: '',
      args: [],
    );
  }

  /// `Register success`
  String get register_activity_register_success_tips {
    return Intl.message(
      'Register success',
      name: 'register_activity_register_success_tips',
      desc: '',
      args: [],
    );
  }

  /// `To start using your X-Bank  account, please verify your email address`
  String get register_activity_register_validate_tips {
    return Intl.message(
      'To start using your X-Bank  account, please verify your email address',
      name: 'register_activity_register_validate_tips',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get main_activity_tab_home {
    return Intl.message(
      'Dashboard',
      name: 'main_activity_tab_home',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get main_activity_tab_deposit {
    return Intl.message(
      'Deposit',
      name: 'main_activity_tab_deposit',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get main_activity_tab_transfer {
    return Intl.message(
      'Transfer',
      name: 'main_activity_tab_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get main_activity_tab_settings {
    return Intl.message(
      'Settings',
      name: 'main_activity_tab_settings',
      desc: '',
      args: [],
    );
  }

  /// `RECIPIENT ADDRESS`
  String get main_activity_fragment_transfer_recipient_address_title {
    return Intl.message(
      'RECIPIENT ADDRESS',
      name: 'main_activity_fragment_transfer_recipient_address_title',
      desc: '',
      args: [],
    );
  }

  /// `XCASH address(must be 98 char)`
  String get main_activity_fragment_transfer_recipient_xcash_address_hint {
    return Intl.message(
      'XCASH address(must be 98 char)',
      name: 'main_activity_fragment_transfer_recipient_xcash_address_hint',
      desc: '',
      args: [],
    );
  }

  /// `WXCASH address`
  String get main_activity_fragment_transfer_recipient_wxcash_address_hint {
    return Intl.message(
      'WXCASH address',
      name: 'main_activity_fragment_transfer_recipient_wxcash_address_hint',
      desc: '',
      args: [],
    );
  }

  /// `PAYMENT ID(OPTIONAL)`
  String get main_activity_fragment_transfer_payment_id_title {
    return Intl.message(
      'PAYMENT ID(OPTIONAL)',
      name: 'main_activity_fragment_transfer_payment_id_title',
      desc: '',
      args: [],
    );
  }

  /// `Payment ID`
  String get main_activity_fragment_transfer_payment_id_hint {
    return Intl.message(
      'Payment ID',
      name: 'main_activity_fragment_transfer_payment_id_hint',
      desc: '',
      args: [],
    );
  }

  /// `AMOUNT`
  String get main_activity_fragment_transfer_amount_title {
    return Intl.message(
      'AMOUNT',
      name: 'main_activity_fragment_transfer_amount_title',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get main_activity_fragment_transfer_send_text {
    return Intl.message(
      'Send',
      name: 'main_activity_fragment_transfer_send_text',
      desc: '',
      args: [],
    );
  }

  /// `New\nTransfer`
  String get main_activity_fragment_transfer_new_transfer_text {
    return Intl.message(
      'New\nTransfer',
      name: 'main_activity_fragment_transfer_new_transfer_text',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get main_activity_fragment_transfer_refresh_text {
    return Intl.message(
      'Refresh',
      name: 'main_activity_fragment_transfer_refresh_text',
      desc: '',
      args: [],
    );
  }

  /// `To proceed with this transfer, please provide your 2FA code below`
  String get main_activity_fragment_transfer_2fa_text {
    return Intl.message(
      'To proceed with this transfer, please provide your 2FA code below',
      name: 'main_activity_fragment_transfer_2fa_text',
      desc: '',
      args: [],
    );
  }

  /// `Deposit XCASH to your account`
  String get main_activity_fragment_deposit_xcash_address_title {
    return Intl.message(
      'Deposit XCASH to your account',
      name: 'main_activity_fragment_deposit_xcash_address_title',
      desc: '',
      args: [],
    );
  }

  /// `To creadit your account,send XCASH to the address below`
  String get main_activity_fragment_deposit_xcash_address_tips {
    return Intl.message(
      'To creadit your account,send XCASH to the address below',
      name: 'main_activity_fragment_deposit_xcash_address_tips',
      desc: '',
      args: [],
    );
  }

  /// `Deposit WXCASH to your account`
  String get main_activity_fragment_deposit_wxcash_address_title {
    return Intl.message(
      'Deposit WXCASH to your account',
      name: 'main_activity_fragment_deposit_wxcash_address_title',
      desc: '',
      args: [],
    );
  }

  /// `To creadit your account,send WXCASH to the address below`
  String get main_activity_fragment_deposit_wxcash_address_tips {
    return Intl.message(
      'To creadit your account,send WXCASH to the address below',
      name: 'main_activity_fragment_deposit_wxcash_address_tips',
      desc: '',
      args: [],
    );
  }

  /// `Copy to clipboard`
  String get main_activity_fragment_deposit_copy_text {
    return Intl.message(
      'Copy to clipboard',
      name: 'main_activity_fragment_deposit_copy_text',
      desc: '',
      args: [],
    );
  }

  /// `Copy to clipboard success`
  String get main_activity_fragment_deposit_copy_success_tips {
    return Intl.message(
      'Copy to clipboard success',
      name: 'main_activity_fragment_deposit_copy_success_tips',
      desc: '',
      args: [],
    );
  }

  /// `or scan the QR-code below`
  String get main_activity_fragment_deposit_scan_tips {
    return Intl.message(
      'or scan the QR-code below',
      name: 'main_activity_fragment_deposit_scan_tips',
      desc: '',
      args: [],
    );
  }

  /// `CREATE TRANSFER`
  String get main_activity_fragment_transfer_create_transfer_title {
    return Intl.message(
      'CREATE TRANSFER',
      name: 'main_activity_fragment_transfer_create_transfer_title',
      desc: '',
      args: [],
    );
  }

  /// `SWAP`
  String get main_activity_fragment_transfer_swap_title {
    return Intl.message(
      'SWAP',
      name: 'main_activity_fragment_transfer_swap_title',
      desc: '',
      args: [],
    );
  }

  /// `Address can't empty`
  String get main_activity_fragment_transfer_address_empty_tips {
    return Intl.message(
      'Address can\'t empty',
      name: 'main_activity_fragment_transfer_address_empty_tips',
      desc: '',
      args: [],
    );
  }

  /// `Amount can't empty`
  String get main_activity_fragment_transfer_amount_empty_tips {
    return Intl.message(
      'Amount can\'t empty',
      name: 'main_activity_fragment_transfer_amount_empty_tips',
      desc: '',
      args: [],
    );
  }

  /// `Transfer success`
  String get main_activity_fragment_transfer_transfer_success_tips {
    return Intl.message(
      'Transfer success',
      name: 'main_activity_fragment_transfer_transfer_success_tips',
      desc: '',
      args: [],
    );
  }

  /// `TOTAL BALANCE`
  String get main_activity_fragment_home_balance_title {
    return Intl.message(
      'TOTAL BALANCE',
      name: 'main_activity_fragment_home_balance_title',
      desc: '',
      args: [],
    );
  }

  /// `ACCOUNT`
  String get main_activity_fragment_settings_account_title {
    return Intl.message(
      'ACCOUNT',
      name: 'main_activity_fragment_settings_account_title',
      desc: '',
      args: [],
    );
  }

  /// `PASSWORD`
  String get main_activity_fragment_settings_password_title {
    return Intl.message(
      'PASSWORD',
      name: 'main_activity_fragment_settings_password_title',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get main_activity_fragment_settings_password_text {
    return Intl.message(
      'Change password',
      name: 'main_activity_fragment_settings_password_text',
      desc: '',
      args: [],
    );
  }

  /// `SYSTEM`
  String get main_activity_fragment_settings_system_title {
    return Intl.message(
      'SYSTEM',
      name: 'main_activity_fragment_settings_system_title',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get main_activity_fragment_settings_language_text {
    return Intl.message(
      'Language',
      name: 'main_activity_fragment_settings_language_text',
      desc: '',
      args: [],
    );
  }

  /// `Switch Coin`
  String get main_activity_fragment_settings_switch_coin_text {
    return Intl.message(
      'Switch Coin',
      name: 'main_activity_fragment_settings_switch_coin_text',
      desc: '',
      args: [],
    );
  }

  /// `About X-Bank`
  String get main_activity_fragment_settings_about_text {
    return Intl.message(
      'About X-Bank',
      name: 'main_activity_fragment_settings_about_text',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get main_activity_fragment_settings_log_out_text {
    return Intl.message(
      'Log Out',
      name: 'main_activity_fragment_settings_log_out_text',
      desc: '',
      args: [],
    );
  }

  /// `https://x-bank.io`
  String get main_activity_fragment_settings_about_us_url {
    return Intl.message(
      'https://x-bank.io',
      name: 'main_activity_fragment_settings_about_us_url',
      desc: '',
      args: [],
    );
  }

  /// `Token invalid`
  String get token_invalid_tips {
    return Intl.message(
      'Token invalid',
      name: 'token_invalid_tips',
      desc: '',
      args: [],
    );
  }

  /// `2FA validate`
  String get validate_2fa {
    return Intl.message(
      '2FA validate',
      name: 'validate_2fa',
      desc: '',
      args: [],
    );
  }

  /// `Please input 2FA code`
  String get input_2FA_code_hint {
    return Intl.message(
      'Please input 2FA code',
      name: 'input_2FA_code_hint',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Details`
  String get transfer_details_activity_title {
    return Intl.message(
      'Transfer Details',
      name: 'transfer_details_activity_title',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Info:`
  String get transfer_details_activity_transfer_info_text {
    return Intl.message(
      'Transfer Info:',
      name: 'transfer_details_activity_transfer_info_text',
      desc: '',
      args: [],
    );
  }

  /// `Tx type:`
  String get transfer_details_activity_transfer_tx_type_text {
    return Intl.message(
      'Tx type:',
      name: 'transfer_details_activity_transfer_tx_type_text',
      desc: '',
      args: [],
    );
  }

  /// `Tx hash:`
  String get transfer_details_activity_transfer_tx_hash_text {
    return Intl.message(
      'Tx hash:',
      name: 'transfer_details_activity_transfer_tx_hash_text',
      desc: '',
      args: [],
    );
  }

  /// `Tx key:`
  String get transfer_details_activity_transfer_tx_key_text {
    return Intl.message(
      'Tx key:',
      name: 'transfer_details_activity_transfer_tx_key_text',
      desc: '',
      args: [],
    );
  }

  /// `Address:`
  String get transfer_details_activity_transfer_recipient_address_text {
    return Intl.message(
      'Address:',
      name: 'transfer_details_activity_transfer_recipient_address_text',
      desc: '',
      args: [],
    );
  }

  /// `Block height:`
  String get transfer_details_activity_transfer_block_height_text {
    return Intl.message(
      'Block height:',
      name: 'transfer_details_activity_transfer_block_height_text',
      desc: '',
      args: [],
    );
  }

  /// `Amount:`
  String get transfer_details_activity_transfer_amount_text {
    return Intl.message(
      'Amount:',
      name: 'transfer_details_activity_transfer_amount_text',
      desc: '',
      args: [],
    );
  }

  /// `Fee:`
  String get transfer_details_activity_transfer_fee_text {
    return Intl.message(
      'Fee:',
      name: 'transfer_details_activity_transfer_fee_text',
      desc: '',
      args: [],
    );
  }

  /// `Amount USD:`
  String get transfer_details_activity_transfer_amount_usd_text {
    return Intl.message(
      'Amount USD:',
      name: 'transfer_details_activity_transfer_amount_usd_text',
      desc: '',
      args: [],
    );
  }

  /// `Status:`
  String get transfer_details_activity_transfer_status_text {
    return Intl.message(
      'Status:',
      name: 'transfer_details_activity_transfer_status_text',
      desc: '',
      args: [],
    );
  }

  /// `Payment id:`
  String get transfer_details_activity_transfer_payment_id_text {
    return Intl.message(
      'Payment id:',
      name: 'transfer_details_activity_transfer_payment_id_text',
      desc: '',
      args: [],
    );
  }

  /// `Time:`
  String get transfer_details_activity_transfer_payment_time_text {
    return Intl.message(
      'Time:',
      name: 'transfer_details_activity_transfer_payment_time_text',
      desc: '',
      args: [],
    );
  }

  /// `Old password:`
  String get change_password_activity_old_password_text {
    return Intl.message(
      'Old password:',
      name: 'change_password_activity_old_password_text',
      desc: '',
      args: [],
    );
  }

  /// `Please input old password`
  String get change_password_activity_old_password_hint {
    return Intl.message(
      'Please input old password',
      name: 'change_password_activity_old_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password_activity_title {
    return Intl.message(
      'Change password',
      name: 'change_password_activity_title',
      desc: '',
      args: [],
    );
  }

  /// `Password:`
  String get change_password_activity_password_text {
    return Intl.message(
      'Password:',
      name: 'change_password_activity_password_text',
      desc: '',
      args: [],
    );
  }

  /// `Please input password`
  String get change_password_activity_password_hint {
    return Intl.message(
      'Please input password',
      name: 'change_password_activity_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password:`
  String get change_password_activity_confirm_password_text {
    return Intl.message(
      'Confirm password:',
      name: 'change_password_activity_confirm_password_text',
      desc: '',
      args: [],
    );
  }

  /// `Please input password again`
  String get change_password_activity_confirm_password_hint {
    return Intl.message(
      'Please input password again',
      name: 'change_password_activity_confirm_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Old password and password can\'t empty`
  String get change_password_activity_password_empty_tips {
    return Intl.message(
      'Old password and password can\\\'t empty',
      name: 'change_password_activity_password_empty_tips',
      desc: '',
      args: [],
    );
  }

  /// `Update password success`
  String get change_password_activity_update_password_success_tips {
    return Intl.message(
      'Update password success',
      name: 'change_password_activity_update_password_success_tips',
      desc: '',
      args: [],
    );
  }

  /// `Password not same`
  String get change_password_activity_password_not_same_tips {
    return Intl.message(
      'Password not same',
      name: 'change_password_activity_password_not_same_tips',
      desc: '',
      args: [],
    );
  }

  /// `Commit`
  String get change_password_activity_commit_text {
    return Intl.message(
      'Commit',
      name: 'change_password_activity_commit_text',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get change_language_activity_title {
    return Intl.message(
      'Change language',
      name: 'change_language_activity_title',
      desc: '',
      args: [],
    );
  }

  /// `ENGLISH`
  String get change_language_activity_english_text {
    return Intl.message(
      'ENGLISH',
      name: 'change_language_activity_english_text',
      desc: '',
      args: [],
    );
  }

  /// `CHINESE`
  String get change_language_activity_chinese_text {
    return Intl.message(
      'CHINESE',
      name: 'change_language_activity_chinese_text',
      desc: '',
      args: [],
    );
  }

  /// `Switch Coin`
  String get switch_coin_activity_title {
    return Intl.message(
      'Switch Coin',
      name: 'switch_coin_activity_title',
      desc: '',
      args: [],
    );
  }

  /// `XCASH`
  String get switch_coin_activity_xcash_text {
    return Intl.message(
      'XCASH',
      name: 'switch_coin_activity_xcash_text',
      desc: '',
      args: [],
    );
  }

  /// `WXCASH`
  String get switch_coin_activity_wxcash_text {
    return Intl.message(
      'WXCASH',
      name: 'switch_coin_activity_wxcash_text',
      desc: '',
      args: [],
    );
  }

  /// `Swap`
  String get swap_activity_title {
    return Intl.message(
      'Swap',
      name: 'swap_activity_title',
      desc: '',
      args: [],
    );
  }

  /// `Swap`
  String get swap_activity_button_text {
    return Intl.message(
      'Swap',
      name: 'swap_activity_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Amount can't empty`
  String get swap_activity_amount_empty_tips {
    return Intl.message(
      'Amount can\'t empty',
      name: 'swap_activity_amount_empty_tips',
      desc: '',
      args: [],
    );
  }

  /// `Swap success`
  String get swap_activity_success_tips {
    return Intl.message(
      'Swap success',
      name: 'swap_activity_success_tips',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("x-bank"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "change_language_activity_chinese_text":
            MessageLookupByLibrary.simpleMessage("CHINESE"),
        "change_language_activity_english_text":
            MessageLookupByLibrary.simpleMessage("ENGLISH"),
        "change_language_activity_title":
            MessageLookupByLibrary.simpleMessage("Change language"),
        "change_password_activity_commit_text":
            MessageLookupByLibrary.simpleMessage("Commit"),
        "change_password_activity_confirm_password_hint":
            MessageLookupByLibrary.simpleMessage("Please input password again"),
        "change_password_activity_confirm_password_text":
            MessageLookupByLibrary.simpleMessage("Confirm password:"),
        "change_password_activity_old_password_hint":
            MessageLookupByLibrary.simpleMessage("Please input old password"),
        "change_password_activity_old_password_text":
            MessageLookupByLibrary.simpleMessage("Old password:"),
        "change_password_activity_password_empty_tips":
            MessageLookupByLibrary.simpleMessage(
                "Old password and password can\\\'t empty"),
        "change_password_activity_password_hint":
            MessageLookupByLibrary.simpleMessage("Please input password"),
        "change_password_activity_password_not_same_tips":
            MessageLookupByLibrary.simpleMessage("Password not same"),
        "change_password_activity_password_text":
            MessageLookupByLibrary.simpleMessage("Password:"),
        "change_password_activity_title":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "change_password_activity_update_password_success_tips":
            MessageLookupByLibrary.simpleMessage("Update password success"),
        "copy_success": MessageLookupByLibrary.simpleMessage("Copy success"),
        "exit_tips":
            MessageLookupByLibrary.simpleMessage("Click again to exit"),
        "input_2FA_code_hint":
            MessageLookupByLibrary.simpleMessage("Please input 2FA code"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
        "login_activity_account_hint":
            MessageLookupByLibrary.simpleMessage("Please input account"),
        "login_activity_account_or_password_empty_tips":
            MessageLookupByLibrary.simpleMessage(
                "Account and password can\'t empty"),
        "login_activity_login_2fa_title":
            MessageLookupByLibrary.simpleMessage("Enter your 2FA code"),
        "login_activity_login_text":
            MessageLookupByLibrary.simpleMessage("Login"),
        "login_activity_login_title":
            MessageLookupByLibrary.simpleMessage("Login"),
        "login_activity_password_hint":
            MessageLookupByLibrary.simpleMessage("Please input password"),
        "login_activity_register_text": MessageLookupByLibrary.simpleMessage(
            "I don\'t have an account.I want to register"),
        "main_activity_fragment_deposit_address_tips":
            MessageLookupByLibrary.simpleMessage(
                "To creadit your account,send XCASH to the address below"),
        "main_activity_fragment_deposit_address_title":
            MessageLookupByLibrary.simpleMessage(
                "Deposit XCASH to your account"),
        "main_activity_fragment_deposit_copy_success_tips":
            MessageLookupByLibrary.simpleMessage("Copy to clipboard success"),
        "main_activity_fragment_deposit_copy_text":
            MessageLookupByLibrary.simpleMessage("Copy to clipboard"),
        "main_activity_fragment_deposit_scan_tips":
            MessageLookupByLibrary.simpleMessage("or scan the QR-code below"),
        "main_activity_fragment_home_balance_title":
            MessageLookupByLibrary.simpleMessage("TOTAL BALANCE"),
        "main_activity_fragment_settings_about_text":
            MessageLookupByLibrary.simpleMessage("About X-Bank"),
        "main_activity_fragment_settings_about_us_url":
            MessageLookupByLibrary.simpleMessage("https://x-bank.io"),
        "main_activity_fragment_settings_account_title":
            MessageLookupByLibrary.simpleMessage("ACCOUNT"),
        "main_activity_fragment_settings_language_text":
            MessageLookupByLibrary.simpleMessage("Language"),
        "main_activity_fragment_settings_log_out_text":
            MessageLookupByLibrary.simpleMessage("Log Out"),
        "main_activity_fragment_settings_password_text":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "main_activity_fragment_settings_password_title":
            MessageLookupByLibrary.simpleMessage("PASSWORD"),
        "main_activity_fragment_settings_system_title":
            MessageLookupByLibrary.simpleMessage("SYSTEM"),
        "main_activity_fragment_transfer_2fa_text":
            MessageLookupByLibrary.simpleMessage(
                "To proceed with this transfer, please provide your 2FA code below"),
        "main_activity_fragment_transfer_address_empty_tips":
            MessageLookupByLibrary.simpleMessage("Address can\'t empty"),
        "main_activity_fragment_transfer_amount_empty_tips":
            MessageLookupByLibrary.simpleMessage("Amount can\'t empty"),
        "main_activity_fragment_transfer_amount_title":
            MessageLookupByLibrary.simpleMessage("AMOUNT"),
        "main_activity_fragment_transfer_create_transfer_title":
            MessageLookupByLibrary.simpleMessage("CREATE TRANSFER"),
        "main_activity_fragment_transfer_new_transfer_text":
            MessageLookupByLibrary.simpleMessage("New\nTransfer"),
        "main_activity_fragment_transfer_payment_id_hint":
            MessageLookupByLibrary.simpleMessage("Payment ID"),
        "main_activity_fragment_transfer_payment_id_title":
            MessageLookupByLibrary.simpleMessage("PAYMENT ID(OPTIONAL)"),
        "main_activity_fragment_transfer_recipient_address_hint":
            MessageLookupByLibrary.simpleMessage(
                "XCASH address(must be 98 char)"),
        "main_activity_fragment_transfer_recipient_address_title":
            MessageLookupByLibrary.simpleMessage("RECIPIENT ADDRESS"),
        "main_activity_fragment_transfer_refresh_text":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "main_activity_fragment_transfer_send_text":
            MessageLookupByLibrary.simpleMessage("Send"),
        "main_activity_fragment_transfer_transfer_success_tips":
            MessageLookupByLibrary.simpleMessage("Transfer success"),
        "main_activity_tab_deposit":
            MessageLookupByLibrary.simpleMessage("Deposit"),
        "main_activity_tab_home":
            MessageLookupByLibrary.simpleMessage("Dashboard"),
        "main_activity_tab_settings":
            MessageLookupByLibrary.simpleMessage("Settings"),
        "main_activity_tab_transfer":
            MessageLookupByLibrary.simpleMessage("Transfer"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "processing": MessageLookupByLibrary.simpleMessage("Processing..."),
        "register_activity_confirm_password_hint":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "register_activity_email_hint":
            MessageLookupByLibrary.simpleMessage("Email"),
        "register_activity_first_name_hint":
            MessageLookupByLibrary.simpleMessage("First Name"),
        "register_activity_last_name_hint":
            MessageLookupByLibrary.simpleMessage("Last Name"),
        "register_activity_login_text": MessageLookupByLibrary.simpleMessage(
            "I have an account.I want to login"),
        "register_activity_params_empty_tips":
            MessageLookupByLibrary.simpleMessage("Params empty"),
        "register_activity_password_hint":
            MessageLookupByLibrary.simpleMessage("Password"),
        "register_activity_password_not_same_tips":
            MessageLookupByLibrary.simpleMessage("Password not same"),
        "register_activity_referral_id_hint":
            MessageLookupByLibrary.simpleMessage("Referral ID"),
        "register_activity_register_success_tips":
            MessageLookupByLibrary.simpleMessage("Register success"),
        "register_activity_register_text":
            MessageLookupByLibrary.simpleMessage("Register"),
        "register_activity_register_title":
            MessageLookupByLibrary.simpleMessage("Register"),
        "register_activity_register_validate_tips":
            MessageLookupByLibrary.simpleMessage(
                "To start using your X-Bank  account, please verify your email address"),
        "server_error": MessageLookupByLibrary.simpleMessage("Server error"),
        "submit": MessageLookupByLibrary.simpleMessage("Submit"),
        "token_invalid_tips":
            MessageLookupByLibrary.simpleMessage("Token invalid"),
        "transfer_details_activity_title":
            MessageLookupByLibrary.simpleMessage("Transfer Details"),
        "transfer_details_activity_transfer_amount_text":
            MessageLookupByLibrary.simpleMessage("Amount:"),
        "transfer_details_activity_transfer_amount_usd_text":
            MessageLookupByLibrary.simpleMessage("Amount USD:"),
        "transfer_details_activity_transfer_block_height_text":
            MessageLookupByLibrary.simpleMessage("Block height:"),
        "transfer_details_activity_transfer_fee_text":
            MessageLookupByLibrary.simpleMessage("Fee:"),
        "transfer_details_activity_transfer_info_text":
            MessageLookupByLibrary.simpleMessage("Transfer Info:"),
        "transfer_details_activity_transfer_payment_id_text":
            MessageLookupByLibrary.simpleMessage("Payment id:"),
        "transfer_details_activity_transfer_payment_time_text":
            MessageLookupByLibrary.simpleMessage("Time:"),
        "transfer_details_activity_transfer_recipient_address_text":
            MessageLookupByLibrary.simpleMessage("Address:"),
        "transfer_details_activity_transfer_status_text":
            MessageLookupByLibrary.simpleMessage("Status:"),
        "transfer_details_activity_transfer_tx_hash_text":
            MessageLookupByLibrary.simpleMessage("Tx hash:"),
        "transfer_details_activity_transfer_tx_key_text":
            MessageLookupByLibrary.simpleMessage("Tx key:"),
        "transfer_details_activity_transfer_tx_type_text":
            MessageLookupByLibrary.simpleMessage("Tx type:"),
        "usd_unit_text": MessageLookupByLibrary.simpleMessage("USD"),
        "validate_2fa": MessageLookupByLibrary.simpleMessage("2FA validate"),
        "xcash_unit_text": MessageLookupByLibrary.simpleMessage("XCASH")
      };
}

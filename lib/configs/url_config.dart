import 'package:framework/utils/device_util.dart';

class UrlConfig {
  static const String urlKey = "#key#";
  static const String urlKey1 = "#key1#";

  static const String release_url = "https://api.x-bank.io/v1";

  static const String debug_url = "https://api.x-bank.io/v1";

  static String getBaseUrl() {
    return DeviceUtil.isDebug() ? release_url : debug_url;
  }

  static const String users_sign_up = "/users/sign-up";

  static const String users_sign_in = "/users/sign-in";

  static const String users_email_resend_verification =
      "/users/email/resend-verification";

  static const String users_transfers_check =
      "/users/$urlKey/accounts/$urlKey1/transfers/check";

  static const String users_transfers =
      "/users/$urlKey/accounts/$urlKey1/transfers";

  static const String users_accounts_balance_summary =
      "/users/$urlKey/accounts/balance-summary";

  static const String users_account = "/users/$urlKey/account";

  static const String users_password = "/users/password";

  static const String users_accounts = "/users/$urlKey/accounts";

  static const String users_swaps = "/users/$urlKey/swaps";
}

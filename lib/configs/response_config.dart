import 'package:x_bank/models/account.dart';
import 'package:x_bank/models/response/users_accounts_balance_summary_response_data.dart';
import 'package:x_bank/models/response/users_sign_up_response_data.dart';
import 'package:x_bank/models/response/users_transfers_check_response_data.dart';
import 'package:x_bank/models/transfer.dart';
import 'package:x_bank/models/user_info.dart';

class ResponseConfig {
  static T convertResponse<T>(dynamic json) {
    String type = T.toString();
    int index = type.lastIndexOf("?");
    if (index != -1) {
      type = type.substring(0, index);
    }
    switch (type) {
      case "UserInfo":
        return UserInfo.fromJson(json) as T;
      case "UsersSignUpResponseData":
        return UsersSignUpResponseData.fromJson(json) as T;
      case "UsersAccountsBalanceSummaryResponseData":
        return UsersAccountsBalanceSummaryResponseData.fromJson(json) as T;
      case "Account":
        return Account.fromJson(json) as T;
      case "Transfer":
        return Transfer.fromJson(json) as T;
      case "UsersTransfersCheckResponseData":
        return UsersTransfersCheckResponseData.fromJson(json) as T;
      default:
        return json as T;
    }
  }
}

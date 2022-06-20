import 'package:json_annotation/json_annotation.dart';

part 'users_accounts_balance_summary_response_data.g.dart';

@JsonSerializable()
class UsersAccountsBalanceSummaryResponseData {
  String? xcash_balance;
  String? bitcoin_balance;
  String? usd_balance;

  UsersAccountsBalanceSummaryResponseData();

  factory UsersAccountsBalanceSummaryResponseData.fromJson(
          Map<String, dynamic> json) =>
      _$UsersAccountsBalanceSummaryResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UsersAccountsBalanceSummaryResponseDataToJson(this);
}

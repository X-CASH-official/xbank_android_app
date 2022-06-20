// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_accounts_balance_summary_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersAccountsBalanceSummaryResponseData
    _$UsersAccountsBalanceSummaryResponseDataFromJson(
            Map<String, dynamic> json) =>
        UsersAccountsBalanceSummaryResponseData()
          ..xcash_balance = json['xcash_balance'] as String?
          ..bitcoin_balance = json['bitcoin_balance'] as String?
          ..usd_balance = json['usd_balance'] as String?;

Map<String, dynamic> _$UsersAccountsBalanceSummaryResponseDataToJson(
        UsersAccountsBalanceSummaryResponseData instance) =>
    <String, dynamic>{
      'xcash_balance': instance.xcash_balance,
      'bitcoin_balance': instance.bitcoin_balance,
      'usd_balance': instance.usd_balance,
    };

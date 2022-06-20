import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  String? id;
  String? user_id;
  String? payment_id;
  String? wallet_id;
  String? integrated_address;
  int? balance_atomic;
  String? currency;
  double? balance_usd;
  int? last_sync_height;
  String? created_at;
  String? updated_at;

  Account();

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

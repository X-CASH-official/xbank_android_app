import 'package:json_annotation/json_annotation.dart';

part 'users_transfers_check_response_data.g.dart';

@JsonSerializable()
class UsersTransfersCheckResponseData {
  String? id;
  String? account_id;
  double? atomic_amount;
  double? atomic_fee;
  String? currency;
  double? amount_usd;
  int? block_height;
  String? payment_id;
  String? recipient_address;
  String? tx_hash;
  String? tx_key;
  int? unlock_time;
  String? status;
  String? type;
  bool? is_xbank_only;
  String? created_at;
  String? updated_at;

  UsersTransfersCheckResponseData();

  factory UsersTransfersCheckResponseData.fromJson(Map<String, dynamic> json) =>
      _$UsersTransfersCheckResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$UsersTransfersCheckResponseDataToJson(this);
}

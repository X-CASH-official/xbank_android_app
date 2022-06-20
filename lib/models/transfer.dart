import 'package:json_annotation/json_annotation.dart';

part 'transfer.g.dart';

@JsonSerializable()
class Transfer {
  String? id;
  String? currency;
  String? type;
  String? tx_hash;
  String? tx_key;
  int? block_height;
  String? payment_id;
  String? recipient_address;
  int? atomic_amount;
  double? amount_usd;
  String? created_at;
  int? atomic_fee;
  bool? is_xbank_only;
  String? status;

  Transfer();

  factory Transfer.fromJson(Map<String, dynamic> json) =>
      _$TransferFromJson(json);

  Map<String, dynamic> toJson() => _$TransferToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transfer _$TransferFromJson(Map<String, dynamic> json) => Transfer()
  ..id = json['id'] as String?
  ..currency = json['currency'] as String?
  ..type = json['type'] as String?
  ..tx_hash = json['tx_hash'] as String?
  ..tx_key = json['tx_key'] as String?
  ..block_height = json['block_height'] as int?
  ..payment_id = json['payment_id'] as String?
  ..recipient_address = json['recipient_address'] as String?
  ..atomic_amount = json['atomic_amount'] as int?
  ..amount_usd = (json['amount_usd'] as num?)?.toDouble()
  ..created_at = json['created_at'] as String?
  ..atomic_fee = json['atomic_fee'] as int?
  ..is_xbank_only = json['is_xbank_only'] as bool?
  ..status = json['status'] as String?;

Map<String, dynamic> _$TransferToJson(Transfer instance) => <String, dynamic>{
      'id': instance.id,
      'currency': instance.currency,
      'type': instance.type,
      'tx_hash': instance.tx_hash,
      'tx_key': instance.tx_key,
      'block_height': instance.block_height,
      'payment_id': instance.payment_id,
      'recipient_address': instance.recipient_address,
      'atomic_amount': instance.atomic_amount,
      'amount_usd': instance.amount_usd,
      'created_at': instance.created_at,
      'atomic_fee': instance.atomic_fee,
      'is_xbank_only': instance.is_xbank_only,
      'status': instance.status,
    };

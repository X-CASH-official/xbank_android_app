// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_transfers_check_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersTransfersCheckResponseData _$UsersTransfersCheckResponseDataFromJson(
        Map<String, dynamic> json) =>
    UsersTransfersCheckResponseData()
      ..id = json['id'] as String?
      ..account_id = json['account_id'] as String?
      ..atomic_amount = (json['atomic_amount'] as num?)?.toDouble()
      ..atomic_fee = (json['atomic_fee'] as num?)?.toDouble()
      ..currency = json['currency'] as String?
      ..amount_usd = (json['amount_usd'] as num?)?.toDouble()
      ..block_height = json['block_height'] as int?
      ..payment_id = json['payment_id'] as String?
      ..recipient_address = json['recipient_address'] as String?
      ..tx_hash = json['tx_hash'] as String?
      ..tx_key = json['tx_key'] as String?
      ..unlock_time = json['unlock_time'] as int?
      ..status = json['status'] as String?
      ..type = json['type'] as String?
      ..is_xbank_only = json['is_xbank_only'] as bool?
      ..created_at = json['created_at'] as String?
      ..updated_at = json['updated_at'] as String?;

Map<String, dynamic> _$UsersTransfersCheckResponseDataToJson(
        UsersTransfersCheckResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_id': instance.account_id,
      'atomic_amount': instance.atomic_amount,
      'atomic_fee': instance.atomic_fee,
      'currency': instance.currency,
      'amount_usd': instance.amount_usd,
      'block_height': instance.block_height,
      'payment_id': instance.payment_id,
      'recipient_address': instance.recipient_address,
      'tx_hash': instance.tx_hash,
      'tx_key': instance.tx_key,
      'unlock_time': instance.unlock_time,
      'status': instance.status,
      'type': instance.type,
      'is_xbank_only': instance.is_xbank_only,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account()
  ..id = json['id'] as String?
  ..user_id = json['user_id'] as String?
  ..payment_id = json['payment_id'] as String?
  ..wallet_id = json['wallet_id'] as String?
  ..integrated_address = json['integrated_address'] as String?
  ..balance_atomic = json['balance_atomic'] as int?
  ..currency = json['currency'] as String?
  ..balance_usd = (json['balance_usd'] as num?)?.toDouble()
  ..last_sync_height = json['last_sync_height'] as int?
  ..created_at = json['created_at'] as String?
  ..updated_at = json['updated_at'] as String?;

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'payment_id': instance.payment_id,
      'wallet_id': instance.wallet_id,
      'integrated_address': instance.integrated_address,
      'balance_atomic': instance.balance_atomic,
      'currency': instance.currency,
      'balance_usd': instance.balance_usd,
      'last_sync_height': instance.last_sync_height,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

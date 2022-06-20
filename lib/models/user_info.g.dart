// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo()
  ..username = json['username'] as String?
  ..user_id = json['user_id'] as String?
  ..access_token = json['access_token'] as String?
  ..access_token_expires_at = json['access_token_expires_at'] as String?
  ..refresh_token = json['refresh_token'] as String?;

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'username': instance.username,
      'user_id': instance.user_id,
      'access_token': instance.access_token,
      'access_token_expires_at': instance.access_token_expires_at,
      'refresh_token': instance.refresh_token,
    };

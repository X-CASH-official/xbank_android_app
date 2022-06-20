// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_sign_up_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersSignUpResponseData _$UsersSignUpResponseDataFromJson(
        Map<String, dynamic> json) =>
    UsersSignUpResponseData()
      ..id = json['id'] as String?
      ..first_name = json['first_name'] as String?
      ..last_name = json['last_name'] as String?
      ..provider = json['provider'] as String?
      ..username = json['username'] as String?;

Map<String, dynamic> _$UsersSignUpResponseDataToJson(
        UsersSignUpResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'provider': instance.provider,
      'username': instance.username,
    };

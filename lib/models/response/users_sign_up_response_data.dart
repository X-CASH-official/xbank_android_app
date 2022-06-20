import 'package:json_annotation/json_annotation.dart';

part 'users_sign_up_response_data.g.dart';

@JsonSerializable()
class UsersSignUpResponseData {
  String? id;
  String? first_name;
  String? last_name;
  String? provider;
  String? username;

  UsersSignUpResponseData();

  factory UsersSignUpResponseData.fromJson(Map<String, dynamic> json) =>
      _$UsersSignUpResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$UsersSignUpResponseDataToJson(this);
}

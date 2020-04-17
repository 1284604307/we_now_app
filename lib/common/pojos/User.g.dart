// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..username = json['username'] as String
    ..create = json['create'] as String
    ..like = json['like'] as String
    ..collect = json['collect'] as String
    ..footer = json['footer'] as String
    ..lv = json['lv'] as String
    ..name = json['name'] as String
    ..avatar = json['avatar'] as String
    ..userId = json['userId']
    ..loginDate = json['loginDate']
    ..email = json['email']
    ..phone = json['phone']
    ..sex = json['sex'];
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'create': instance.create,
      'like': instance.like,
      'collect': instance.collect,
      'footer': instance.footer,
      'lv': instance.lv,
      'name': instance.name,
      'avatar': instance.avatar,
      'userId': instance.userId,
      'loginDate': instance.loginDate,
      'email': instance.email,
      'phone': instance.phone,
      'sex': instance.sex,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..loginName = json['loginName'] as String
    ..userName = json['userName'] as String
    ..createTime = json['createTime'] as String
    ..createCount = json['createCount'] as int
    ..avatar = json['avatar'] as String
    ..likeCount = json['likeCount'] as int
    ..collectCount = json['collectCount'] as int
    ..followCount = json['followCount'] as int
    ..fansCount = json['fansCount'] as int
    ..lv = json['lv'] as int
    ..userId = json['userId']
    ..loginDate = json['loginDate']
    ..email = json['email']
    ..phonenumber = json['phonenumber']
    ..sex = json['sex']
    ..schoolId = json['schoolId']
    ..ticket = json['ticket'];
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'loginName': instance.loginName,
      'userName': instance.userName,
      'createTime': instance.createTime,
      'createCount': instance.createCount,
      'avatar': instance.avatar,
      'likeCount': instance.likeCount,
      'collectCount': instance.collectCount,
      'followCount': instance.followCount,
      'fansCount': instance.fansCount,
      'lv': instance.lv,
      'userId': instance.userId,
      'loginDate': instance.loginDate,
      'email': instance.email,
      'phonenumber': instance.phonenumber,
      'sex': instance.sex,
      'schoolId': instance.schoolId,
    };

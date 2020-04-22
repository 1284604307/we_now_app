// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostEntity _$PostEntityFromJson(Map<String, dynamic> json) {
  return PostEntity(
    id: json['id'] as int,
    userId: json['userId'] as int,
    type: _$enumDecodeNullable(_$PostTypeEnumMap, json['type']),
    text: json['text'] as String,
    imageIds: (json['imageIds'] as List)?.map((e) => e as int)?.toList(),
    videoId: json['videoId'] as int,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    user: json['user'] == null
        ? null
        : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    images: (json['images'] as List)
        ?.map((e) =>
            e == null ? null : FileEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    video: json['video'] == null
        ? null
        : FileEntity.fromJson(json['video'] as Map<String, dynamic>),
    stat: json['stat'] == null
        ? null
        : PostStatEntity.fromJson(json['stat'] as Map<String, dynamic>),
    liked: json['liked'] as bool ?? false,
  );
}

Map<String, dynamic> _$PostEntityToJson(PostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$PostTypeEnumMap[instance.type],
      'text': instance.text,
      'imageIds': instance.imageIds,
      'videoId': instance.videoId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'user': instance.user,
      'images': instance.images,
      'video': instance.video,
      'stat': instance.stat,
      'liked': instance.liked,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PostTypeEnumMap = {
  PostType.TEXT: 'TEXT',
  PostType.IMAGE: 'IMAGE',
  PostType.VIDEO: 'VIDEO',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileEntity _$FileEntityFromJson(Map<String, dynamic> json) {
  return FileEntity(
    id: json['id'] as int,
    userId: json['userId'] as int,
    region: json['region'] as String,
    bucket: json['bucket'] as String,
    path: json['path'] as String,
    meta: json['meta'] == null
        ? null
        : FileMetaEntity.fromJson(json['meta'] as Map<String, dynamic>),
    url: json['url'] as String,
    thumbs: (json['thumbs'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          _$enumDecodeNullable(_$FileThumbTypeEnumMap, k), e as String),
    ),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$FileEntityToJson(FileEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'region': instance.region,
      'bucket': instance.bucket,
      'path': instance.path,
      'meta': instance.meta,
      'url': instance.url,
      'thumbs': instance.thumbs
          ?.map((k, e) => MapEntry(_$FileThumbTypeEnumMap[k], e)),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
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

const _$FileThumbTypeEnumMap = {
  FileThumbType.SMALL: 'SMALL',
  FileThumbType.MIDDLE: 'MIDDLE',
  FileThumbType.LARGE: 'LARGE',
  FileThumbType.HUGE: 'HUGE',
};

FileMetaEntity _$FileMetaEntityFromJson(Map<String, dynamic> json) {
  return FileMetaEntity(
    name: json['name'] as String,
    size: json['size'] as int,
    type: json['type'] as String,
    width: json['width'] as int ?? 0,
    height: json['height'] as int ?? 0,
    duration: json['duration'] as int ?? 0,
  );
}

Map<String, dynamic> _$FileMetaEntityToJson(FileMetaEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'size': instance.size,
      'type': instance.type,
      'width': instance.width,
      'height': instance.height,
      'duration': instance.duration,
    };

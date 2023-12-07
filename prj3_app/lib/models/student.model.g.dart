// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      id: json['_id'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      courses: json['courses'] as List<dynamic>,
      week: const DateTimeConverter().fromJson(json['week'] as int?),
      createdAt: const DateTimeConverter().fromJson(json['createdAt'] as int?),
      updatedAt: const DateTimeConverter().fromJson(json['updatedAt'] as int?),
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'avatar': instance.avatar,
      'courses': instance.courses,
      'week': const DateTimeConverter().toJson(instance.week),
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      timestamp: const DateTimeConverter().fromJson(json['timestamp'] as int?),
      preNotifyTime: json['preNotifyTime'] as int,
      createdAt: const DateTimeConverter().fromJson(json['createdAt'] as int?),
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'timestamp': const DateTimeConverter().toJson(instance.timestamp),
      'preNotifyTime': instance.preNotifyTime,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
    };

_$RemindImpl _$$RemindImplFromJson(Map<String, dynamic> json) => _$RemindImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      schedule: json['schedule'] as Map<String, dynamic>,
      createdAt: const DateTimeConverter().fromJson(json['createdAt'] as int?),
    );

Map<String, dynamic> _$$RemindImplToJson(_$RemindImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'schedule': instance.schedule,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
    };

_$TargetImpl _$$TargetImplFromJson(Map<String, dynamic> json) => _$TargetImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      timestamp: const DateTimeConverter().fromJson(json['timestamp'] as int?),
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: const DateTimeConverter().fromJson(json['createdAt'] as int?),
    );

Map<String, dynamic> _$$TargetImplToJson(_$TargetImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'timestamp': const DateTimeConverter().toJson(instance.timestamp),
      'isCompleted': instance.isCompleted,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
    };

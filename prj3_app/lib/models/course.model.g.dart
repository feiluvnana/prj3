// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
      id: json['_id'] as String?,
      courseId: json['id'] as String,
      name: json['name'] as String,
      midFactor: (json['midFactor'] as num).toDouble(),
      courseFactor: json['courseFactor'] as int,
      schedule: Schedule.fromJson(json['schedule'] as Map<String, dynamic>),
      semester: Semester.fromJson(json['semester'] as Map<String, dynamic>),
      createdAt: const DateTimeConverter().fromJson(json['createdAt'] as int?),
      updatedAt: const DateTimeConverter().fromJson(json['updatedAt'] as int?),
    );

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'id': instance.courseId,
      'name': instance.name,
      'midFactor': instance.midFactor,
      'courseFactor': instance.courseFactor,
      'schedule': instance.schedule.toJson(),
      'semester': instance.semester.toJson(),
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };

_$ScheduleImpl _$$ScheduleImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleImpl(
      id: json['_id'] as String,
      start: json['start'] as int,
      end: json['end'] as int,
      weekday: json['weekday'] as int,
      week: (json['week'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$ScheduleImplToJson(_$ScheduleImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'start': instance.start,
      'end': instance.end,
      'weekday': instance.weekday,
      'week': instance.week,
    };

_$SemesterImpl _$$SemesterImplFromJson(Map<String, dynamic> json) =>
    _$SemesterImpl(
      start: json['start'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$SemesterImplToJson(_$SemesterImpl instance) =>
    <String, dynamic>{
      'start': instance.start,
      'name': instance.name,
    };

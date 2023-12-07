import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prj3_app/helpers/converter.dart';

part 'reminder.model.freezed.dart';
part 'reminder.model.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required String name,
    required String description,
    @DateTimeConverter() DateTime? timestamp,
    required int preNotifyTime,
    @DateTimeConverter() DateTime? createdAt,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

@freezed
class Remind with _$Remind {
  const factory Remind({
    required String name,
    required String description,
    required Map<String, dynamic> schedule,
    @DateTimeConverter() DateTime? createdAt,
  }) = _Remind;

  factory Remind.fromJson(Map<String, dynamic> json) => _$RemindFromJson(json);
}

@freezed
class Target with _$Target {
  const factory Target({
    required String name,
    required String description,
    @DateTimeConverter() DateTime? timestamp,
    @Default(false) bool isCompleted,
    @DateTimeConverter() DateTime? createdAt,
  }) = _Target;

  factory Target.fromJson(Map<String, dynamic> json) => _$TargetFromJson(json);
}

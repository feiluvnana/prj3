import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prj3_app/helpers/converter.dart';

part "course.model.freezed.dart";
part "course.model.g.dart";

@freezed
class Course with _$Course {
  @JsonSerializable(explicitToJson: true)
  const factory Course({
    @JsonKey(name: "_id") String? id,
    @JsonKey(name: "id") required String courseId,
    required String name,
    required double midFactor,
    required int courseFactor,
    required Schedule schedule,
    required Semester semester,
    @DateTimeConverter() DateTime? createdAt,
    @DateTimeConverter() DateTime? updatedAt,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}

@freezed
class Schedule with _$Schedule {
  @JsonSerializable(explicitToJson: true)
  const factory Schedule(
      {@JsonKey(name: "_id") required String id,
      required int start,
      required int end,
      required int weekday,
      required List<int> week}) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);
}

@freezed
class Semester with _$Semester {
  @JsonSerializable(explicitToJson: true)
  const factory Semester({required int start, required String name}) = _Semester;

  factory Semester.fromJson(Map<String, dynamic> json) => _$SemesterFromJson(json);
}

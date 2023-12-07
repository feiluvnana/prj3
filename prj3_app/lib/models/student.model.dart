import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prj3_app/helpers/converter.dart';

part "student.model.freezed.dart";
part "student.model.g.dart";

@freezed
class Student with _$Student {
  @JsonSerializable(explicitToJson: true)
  const factory Student({
    @JsonKey(name: "_id") required String id,
    required String email,
    String? avatar,
    required List<dynamic> courses,
    @DateTimeConverter() DateTime? week,
    @DateTimeConverter() DateTime? createdAt,
    @DateTimeConverter() DateTime? updatedAt,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
}

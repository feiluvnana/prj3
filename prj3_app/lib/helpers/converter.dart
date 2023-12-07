import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeConverter extends JsonConverter<DateTime?, int?> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(int? json) {
    return DateTime.fromMillisecondsSinceEpoch(json ?? 0);
  }

  @override
  int? toJson(DateTime? object) {
    return object?.millisecondsSinceEpoch;
  }
}

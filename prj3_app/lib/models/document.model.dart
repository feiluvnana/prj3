import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prj3_app/helpers/converter.dart';

part "document.model.freezed.dart";
part "document.model.g.dart";

@freezed
class Document with _$Document {
  @JsonSerializable(explicitToJson: true)
  const factory Document({
    @JsonKey(name: "_id") required String id,
    required String name,
    required String originalName,
    required int size,
    required Vote vote,
    required Map<String, dynamic> author,
    required List<Tag> tags,
    @DateTimeConverter() DateTime? createdAt,
    @DateTimeConverter() DateTime? updatedAt,
  }) = _Document;

  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);
}

@freezed
class Vote with _$Vote {
  @JsonSerializable(explicitToJson: true)
  const factory Vote({required List<VoteDetail> detail, required int count}) = _Vote;

  factory Vote.fromJson(Map<String, dynamic> json) => _$VoteFromJson(json);
}

@freezed
class VoteDetail with _$VoteDetail {
  @JsonSerializable(explicitToJson: true)
  const factory VoteDetail({required String author, required int vote}) = _VoteDetail;

  factory VoteDetail.fromJson(Map<String, dynamic> json) => _$VoteDetailFromJson(json);
}

@freezed
class Tag with _$Tag {
  @JsonSerializable(explicitToJson: true)
  const factory Tag(
      {@JsonKey(name: "_id") required String id, required String name, String? description}) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentImpl _$$DocumentImplFromJson(Map<String, dynamic> json) =>
    _$DocumentImpl(
      id: json['_id'] as String,
      name: json['name'] as String,
      originalName: json['originalName'] as String,
      size: json['size'] as int,
      vote: Vote.fromJson(json['vote'] as Map<String, dynamic>),
      author: json['author'] as Map<String, dynamic>,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: const DateTimeConverter().fromJson(json['createdAt'] as int?),
      updatedAt: const DateTimeConverter().fromJson(json['updatedAt'] as int?),
    );

Map<String, dynamic> _$$DocumentImplToJson(_$DocumentImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'originalName': instance.originalName,
      'size': instance.size,
      'vote': instance.vote.toJson(),
      'author': instance.author,
      'tags': instance.tags.map((e) => e.toJson()).toList(),
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };

_$VoteImpl _$$VoteImplFromJson(Map<String, dynamic> json) => _$VoteImpl(
      detail: (json['detail'] as List<dynamic>)
          .map((e) => VoteDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int,
    );

Map<String, dynamic> _$$VoteImplToJson(_$VoteImpl instance) =>
    <String, dynamic>{
      'detail': instance.detail.map((e) => e.toJson()).toList(),
      'count': instance.count,
    };

_$VoteDetailImpl _$$VoteDetailImplFromJson(Map<String, dynamic> json) =>
    _$VoteDetailImpl(
      author: json['author'] as String,
      vote: json['vote'] as int,
    );

Map<String, dynamic> _$$VoteDetailImplToJson(_$VoteDetailImpl instance) =>
    <String, dynamic>{
      'author': instance.author,
      'vote': instance.vote,
    };

_$TagImpl _$$TagImplFromJson(Map<String, dynamic> json) => _$TagImpl(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$TagImplToJson(_$TagImpl instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

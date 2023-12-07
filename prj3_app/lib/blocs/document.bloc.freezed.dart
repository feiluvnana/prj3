// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document.bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DocumentState {
  List<Document> get documents => throw _privateConstructorUsedError;
  List<Document> get myDocuments => throw _privateConstructorUsedError;
  List<Tag> get allTags => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DocumentStateCopyWith<DocumentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentStateCopyWith<$Res> {
  factory $DocumentStateCopyWith(
          DocumentState value, $Res Function(DocumentState) then) =
      _$DocumentStateCopyWithImpl<$Res, DocumentState>;
  @useResult
  $Res call(
      {List<Document> documents,
      List<Document> myDocuments,
      List<Tag> allTags});
}

/// @nodoc
class _$DocumentStateCopyWithImpl<$Res, $Val extends DocumentState>
    implements $DocumentStateCopyWith<$Res> {
  _$DocumentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documents = null,
    Object? myDocuments = null,
    Object? allTags = null,
  }) {
    return _then(_value.copyWith(
      documents: null == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<Document>,
      myDocuments: null == myDocuments
          ? _value.myDocuments
          : myDocuments // ignore: cast_nullable_to_non_nullable
              as List<Document>,
      allTags: null == allTags
          ? _value.allTags
          : allTags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentStateImplCopyWith<$Res>
    implements $DocumentStateCopyWith<$Res> {
  factory _$$DocumentStateImplCopyWith(
          _$DocumentStateImpl value, $Res Function(_$DocumentStateImpl) then) =
      __$$DocumentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Document> documents,
      List<Document> myDocuments,
      List<Tag> allTags});
}

/// @nodoc
class __$$DocumentStateImplCopyWithImpl<$Res>
    extends _$DocumentStateCopyWithImpl<$Res, _$DocumentStateImpl>
    implements _$$DocumentStateImplCopyWith<$Res> {
  __$$DocumentStateImplCopyWithImpl(
      _$DocumentStateImpl _value, $Res Function(_$DocumentStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documents = null,
    Object? myDocuments = null,
    Object? allTags = null,
  }) {
    return _then(_$DocumentStateImpl(
      documents: null == documents
          ? _value._documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<Document>,
      myDocuments: null == myDocuments
          ? _value._myDocuments
          : myDocuments // ignore: cast_nullable_to_non_nullable
              as List<Document>,
      allTags: null == allTags
          ? _value._allTags
          : allTags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
    ));
  }
}

/// @nodoc

class _$DocumentStateImpl implements _DocumentState {
  _$DocumentStateImpl(
      {final List<Document> documents = const [],
      final List<Document> myDocuments = const [],
      final List<Tag> allTags = const []})
      : _documents = documents,
        _myDocuments = myDocuments,
        _allTags = allTags;

  final List<Document> _documents;
  @override
  @JsonKey()
  List<Document> get documents {
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documents);
  }

  final List<Document> _myDocuments;
  @override
  @JsonKey()
  List<Document> get myDocuments {
    if (_myDocuments is EqualUnmodifiableListView) return _myDocuments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_myDocuments);
  }

  final List<Tag> _allTags;
  @override
  @JsonKey()
  List<Tag> get allTags {
    if (_allTags is EqualUnmodifiableListView) return _allTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allTags);
  }

  @override
  String toString() {
    return 'DocumentState(documents: $documents, myDocuments: $myDocuments, allTags: $allTags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentStateImpl &&
            const DeepCollectionEquality()
                .equals(other._documents, _documents) &&
            const DeepCollectionEquality()
                .equals(other._myDocuments, _myDocuments) &&
            const DeepCollectionEquality().equals(other._allTags, _allTags));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_documents),
      const DeepCollectionEquality().hash(_myDocuments),
      const DeepCollectionEquality().hash(_allTags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentStateImplCopyWith<_$DocumentStateImpl> get copyWith =>
      __$$DocumentStateImplCopyWithImpl<_$DocumentStateImpl>(this, _$identity);
}

abstract class _DocumentState implements DocumentState {
  factory _DocumentState(
      {final List<Document> documents,
      final List<Document> myDocuments,
      final List<Tag> allTags}) = _$DocumentStateImpl;

  @override
  List<Document> get documents;
  @override
  List<Document> get myDocuments;
  @override
  List<Tag> get allTags;
  @override
  @JsonKey(ignore: true)
  _$$DocumentStateImplCopyWith<_$DocumentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

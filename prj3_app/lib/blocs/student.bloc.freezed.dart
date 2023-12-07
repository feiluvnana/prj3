// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student.bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StudentState {
  Student? get student => throw _privateConstructorUsedError;
  bool get authenticating => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StudentStateCopyWith<StudentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentStateCopyWith<$Res> {
  factory $StudentStateCopyWith(
          StudentState value, $Res Function(StudentState) then) =
      _$StudentStateCopyWithImpl<$Res, StudentState>;
  @useResult
  $Res call({Student? student, bool authenticating});

  $StudentCopyWith<$Res>? get student;
}

/// @nodoc
class _$StudentStateCopyWithImpl<$Res, $Val extends StudentState>
    implements $StudentStateCopyWith<$Res> {
  _$StudentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? student = freezed,
    Object? authenticating = null,
  }) {
    return _then(_value.copyWith(
      student: freezed == student
          ? _value.student
          : student // ignore: cast_nullable_to_non_nullable
              as Student?,
      authenticating: null == authenticating
          ? _value.authenticating
          : authenticating // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StudentCopyWith<$Res>? get student {
    if (_value.student == null) {
      return null;
    }

    return $StudentCopyWith<$Res>(_value.student!, (value) {
      return _then(_value.copyWith(student: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StudentStateImplCopyWith<$Res>
    implements $StudentStateCopyWith<$Res> {
  factory _$$StudentStateImplCopyWith(
          _$StudentStateImpl value, $Res Function(_$StudentStateImpl) then) =
      __$$StudentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Student? student, bool authenticating});

  @override
  $StudentCopyWith<$Res>? get student;
}

/// @nodoc
class __$$StudentStateImplCopyWithImpl<$Res>
    extends _$StudentStateCopyWithImpl<$Res, _$StudentStateImpl>
    implements _$$StudentStateImplCopyWith<$Res> {
  __$$StudentStateImplCopyWithImpl(
      _$StudentStateImpl _value, $Res Function(_$StudentStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? student = freezed,
    Object? authenticating = null,
  }) {
    return _then(_$StudentStateImpl(
      student: freezed == student
          ? _value.student
          : student // ignore: cast_nullable_to_non_nullable
              as Student?,
      authenticating: null == authenticating
          ? _value.authenticating
          : authenticating // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$StudentStateImpl implements _StudentState {
  _$StudentStateImpl({this.student, this.authenticating = false});

  @override
  final Student? student;
  @override
  @JsonKey()
  final bool authenticating;

  @override
  String toString() {
    return 'StudentState(student: $student, authenticating: $authenticating)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentStateImpl &&
            (identical(other.student, student) || other.student == student) &&
            (identical(other.authenticating, authenticating) ||
                other.authenticating == authenticating));
  }

  @override
  int get hashCode => Object.hash(runtimeType, student, authenticating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentStateImplCopyWith<_$StudentStateImpl> get copyWith =>
      __$$StudentStateImplCopyWithImpl<_$StudentStateImpl>(this, _$identity);
}

abstract class _StudentState implements StudentState {
  factory _StudentState({final Student? student, final bool authenticating}) =
      _$StudentStateImpl;

  @override
  Student? get student;
  @override
  bool get authenticating;
  @override
  @JsonKey(ignore: true)
  _$$StudentStateImplCopyWith<_$StudentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

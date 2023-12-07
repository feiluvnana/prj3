// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get timestamp => throw _privateConstructorUsedError;
  int get preNotifyTime => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {String name,
      String description,
      @DateTimeConverter() DateTime? timestamp,
      int preNotifyTime,
      @DateTimeConverter() DateTime? createdAt});
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? timestamp = freezed,
    Object? preNotifyTime = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preNotifyTime: null == preNotifyTime
          ? _value.preNotifyTime
          : preNotifyTime // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventImplCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$EventImplCopyWith(
          _$EventImpl value, $Res Function(_$EventImpl) then) =
      __$$EventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      @DateTimeConverter() DateTime? timestamp,
      int preNotifyTime,
      @DateTimeConverter() DateTime? createdAt});
}

/// @nodoc
class __$$EventImplCopyWithImpl<$Res>
    extends _$EventCopyWithImpl<$Res, _$EventImpl>
    implements _$$EventImplCopyWith<$Res> {
  __$$EventImplCopyWithImpl(
      _$EventImpl _value, $Res Function(_$EventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? timestamp = freezed,
    Object? preNotifyTime = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$EventImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preNotifyTime: null == preNotifyTime
          ? _value.preNotifyTime
          : preNotifyTime // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventImpl implements _Event {
  const _$EventImpl(
      {required this.name,
      required this.description,
      @DateTimeConverter() this.timestamp,
      required this.preNotifyTime,
      @DateTimeConverter() this.createdAt});

  factory _$EventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  @DateTimeConverter()
  final DateTime? timestamp;
  @override
  final int preNotifyTime;
  @override
  @DateTimeConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Event(name: $name, description: $description, timestamp: $timestamp, preNotifyTime: $preNotifyTime, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.preNotifyTime, preNotifyTime) ||
                other.preNotifyTime == preNotifyTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, description, timestamp, preNotifyTime, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      __$$EventImplCopyWithImpl<_$EventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventImplToJson(
      this,
    );
  }
}

abstract class _Event implements Event {
  const factory _Event(
      {required final String name,
      required final String description,
      @DateTimeConverter() final DateTime? timestamp,
      required final int preNotifyTime,
      @DateTimeConverter() final DateTime? createdAt}) = _$EventImpl;

  factory _Event.fromJson(Map<String, dynamic> json) = _$EventImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  @DateTimeConverter()
  DateTime? get timestamp;
  @override
  int get preNotifyTime;
  @override
  @DateTimeConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Remind _$RemindFromJson(Map<String, dynamic> json) {
  return _Remind.fromJson(json);
}

/// @nodoc
mixin _$Remind {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic> get schedule => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RemindCopyWith<Remind> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemindCopyWith<$Res> {
  factory $RemindCopyWith(Remind value, $Res Function(Remind) then) =
      _$RemindCopyWithImpl<$Res, Remind>;
  @useResult
  $Res call(
      {String name,
      String description,
      Map<String, dynamic> schedule,
      @DateTimeConverter() DateTime? createdAt});
}

/// @nodoc
class _$RemindCopyWithImpl<$Res, $Val extends Remind>
    implements $RemindCopyWith<$Res> {
  _$RemindCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? schedule = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      schedule: null == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RemindImplCopyWith<$Res> implements $RemindCopyWith<$Res> {
  factory _$$RemindImplCopyWith(
          _$RemindImpl value, $Res Function(_$RemindImpl) then) =
      __$$RemindImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      Map<String, dynamic> schedule,
      @DateTimeConverter() DateTime? createdAt});
}

/// @nodoc
class __$$RemindImplCopyWithImpl<$Res>
    extends _$RemindCopyWithImpl<$Res, _$RemindImpl>
    implements _$$RemindImplCopyWith<$Res> {
  __$$RemindImplCopyWithImpl(
      _$RemindImpl _value, $Res Function(_$RemindImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? schedule = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$RemindImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      schedule: null == schedule
          ? _value._schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemindImpl implements _Remind {
  const _$RemindImpl(
      {required this.name,
      required this.description,
      required final Map<String, dynamic> schedule,
      @DateTimeConverter() this.createdAt})
      : _schedule = schedule;

  factory _$RemindImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemindImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  final Map<String, dynamic> _schedule;
  @override
  Map<String, dynamic> get schedule {
    if (_schedule is EqualUnmodifiableMapView) return _schedule;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_schedule);
  }

  @override
  @DateTimeConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Remind(name: $name, description: $description, schedule: $schedule, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemindImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._schedule, _schedule) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description,
      const DeepCollectionEquality().hash(_schedule), createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemindImplCopyWith<_$RemindImpl> get copyWith =>
      __$$RemindImplCopyWithImpl<_$RemindImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RemindImplToJson(
      this,
    );
  }
}

abstract class _Remind implements Remind {
  const factory _Remind(
      {required final String name,
      required final String description,
      required final Map<String, dynamic> schedule,
      @DateTimeConverter() final DateTime? createdAt}) = _$RemindImpl;

  factory _Remind.fromJson(Map<String, dynamic> json) = _$RemindImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  Map<String, dynamic> get schedule;
  @override
  @DateTimeConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$RemindImplCopyWith<_$RemindImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Target _$TargetFromJson(Map<String, dynamic> json) {
  return _Target.fromJson(json);
}

/// @nodoc
mixin _$Target {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get timestamp => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TargetCopyWith<Target> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TargetCopyWith<$Res> {
  factory $TargetCopyWith(Target value, $Res Function(Target) then) =
      _$TargetCopyWithImpl<$Res, Target>;
  @useResult
  $Res call(
      {String name,
      String description,
      @DateTimeConverter() DateTime? timestamp,
      bool isCompleted,
      @DateTimeConverter() DateTime? createdAt});
}

/// @nodoc
class _$TargetCopyWithImpl<$Res, $Val extends Target>
    implements $TargetCopyWith<$Res> {
  _$TargetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? timestamp = freezed,
    Object? isCompleted = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TargetImplCopyWith<$Res> implements $TargetCopyWith<$Res> {
  factory _$$TargetImplCopyWith(
          _$TargetImpl value, $Res Function(_$TargetImpl) then) =
      __$$TargetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      @DateTimeConverter() DateTime? timestamp,
      bool isCompleted,
      @DateTimeConverter() DateTime? createdAt});
}

/// @nodoc
class __$$TargetImplCopyWithImpl<$Res>
    extends _$TargetCopyWithImpl<$Res, _$TargetImpl>
    implements _$$TargetImplCopyWith<$Res> {
  __$$TargetImplCopyWithImpl(
      _$TargetImpl _value, $Res Function(_$TargetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? timestamp = freezed,
    Object? isCompleted = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$TargetImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TargetImpl implements _Target {
  const _$TargetImpl(
      {required this.name,
      required this.description,
      @DateTimeConverter() this.timestamp,
      this.isCompleted = false,
      @DateTimeConverter() this.createdAt});

  factory _$TargetImpl.fromJson(Map<String, dynamic> json) =>
      _$$TargetImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  @DateTimeConverter()
  final DateTime? timestamp;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @DateTimeConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Target(name: $name, description: $description, timestamp: $timestamp, isCompleted: $isCompleted, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TargetImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, description, timestamp, isCompleted, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TargetImplCopyWith<_$TargetImpl> get copyWith =>
      __$$TargetImplCopyWithImpl<_$TargetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TargetImplToJson(
      this,
    );
  }
}

abstract class _Target implements Target {
  const factory _Target(
      {required final String name,
      required final String description,
      @DateTimeConverter() final DateTime? timestamp,
      final bool isCompleted,
      @DateTimeConverter() final DateTime? createdAt}) = _$TargetImpl;

  factory _Target.fromJson(Map<String, dynamic> json) = _$TargetImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  @DateTimeConverter()
  DateTime? get timestamp;
  @override
  bool get isCompleted;
  @override
  @DateTimeConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$TargetImplCopyWith<_$TargetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

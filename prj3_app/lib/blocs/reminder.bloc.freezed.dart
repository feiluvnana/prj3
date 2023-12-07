// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder.bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReminderState {
  List<Remind>? get reminds => throw _privateConstructorUsedError;
  List<Event>? get events => throw _privateConstructorUsedError;
  List<Target>? get targets => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReminderStateCopyWith<ReminderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderStateCopyWith<$Res> {
  factory $ReminderStateCopyWith(
          ReminderState value, $Res Function(ReminderState) then) =
      _$ReminderStateCopyWithImpl<$Res, ReminderState>;
  @useResult
  $Res call(
      {List<Remind>? reminds, List<Event>? events, List<Target>? targets});
}

/// @nodoc
class _$ReminderStateCopyWithImpl<$Res, $Val extends ReminderState>
    implements $ReminderStateCopyWith<$Res> {
  _$ReminderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reminds = freezed,
    Object? events = freezed,
    Object? targets = freezed,
  }) {
    return _then(_value.copyWith(
      reminds: freezed == reminds
          ? _value.reminds
          : reminds // ignore: cast_nullable_to_non_nullable
              as List<Remind>?,
      events: freezed == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<Event>?,
      targets: freezed == targets
          ? _value.targets
          : targets // ignore: cast_nullable_to_non_nullable
              as List<Target>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReminderStateImplCopyWith<$Res>
    implements $ReminderStateCopyWith<$Res> {
  factory _$$ReminderStateImplCopyWith(
          _$ReminderStateImpl value, $Res Function(_$ReminderStateImpl) then) =
      __$$ReminderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Remind>? reminds, List<Event>? events, List<Target>? targets});
}

/// @nodoc
class __$$ReminderStateImplCopyWithImpl<$Res>
    extends _$ReminderStateCopyWithImpl<$Res, _$ReminderStateImpl>
    implements _$$ReminderStateImplCopyWith<$Res> {
  __$$ReminderStateImplCopyWithImpl(
      _$ReminderStateImpl _value, $Res Function(_$ReminderStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reminds = freezed,
    Object? events = freezed,
    Object? targets = freezed,
  }) {
    return _then(_$ReminderStateImpl(
      reminds: freezed == reminds
          ? _value._reminds
          : reminds // ignore: cast_nullable_to_non_nullable
              as List<Remind>?,
      events: freezed == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<Event>?,
      targets: freezed == targets
          ? _value._targets
          : targets // ignore: cast_nullable_to_non_nullable
              as List<Target>?,
    ));
  }
}

/// @nodoc

class _$ReminderStateImpl implements _ReminderState {
  const _$ReminderStateImpl(
      {final List<Remind>? reminds,
      final List<Event>? events,
      final List<Target>? targets})
      : _reminds = reminds,
        _events = events,
        _targets = targets;

  final List<Remind>? _reminds;
  @override
  List<Remind>? get reminds {
    final value = _reminds;
    if (value == null) return null;
    if (_reminds is EqualUnmodifiableListView) return _reminds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Event>? _events;
  @override
  List<Event>? get events {
    final value = _events;
    if (value == null) return null;
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Target>? _targets;
  @override
  List<Target>? get targets {
    final value = _targets;
    if (value == null) return null;
    if (_targets is EqualUnmodifiableListView) return _targets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ReminderState(reminds: $reminds, events: $events, targets: $targets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderStateImpl &&
            const DeepCollectionEquality().equals(other._reminds, _reminds) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            const DeepCollectionEquality().equals(other._targets, _targets));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_reminds),
      const DeepCollectionEquality().hash(_events),
      const DeepCollectionEquality().hash(_targets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderStateImplCopyWith<_$ReminderStateImpl> get copyWith =>
      __$$ReminderStateImplCopyWithImpl<_$ReminderStateImpl>(this, _$identity);
}

abstract class _ReminderState implements ReminderState {
  const factory _ReminderState(
      {final List<Remind>? reminds,
      final List<Event>? events,
      final List<Target>? targets}) = _$ReminderStateImpl;

  @override
  List<Remind>? get reminds;
  @override
  List<Event>? get events;
  @override
  List<Target>? get targets;
  @override
  @JsonKey(ignore: true)
  _$$ReminderStateImplCopyWith<_$ReminderStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'availability_time_slot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AvailabilityTimeSlot _$AvailabilityTimeSlotFromJson(Map<String, dynamic> json) {
  return _AvailabilityTimeSlot.fromJson(json);
}

/// @nodoc
mixin _$AvailabilityTimeSlot {
  String? get id => throw _privateConstructorUsedError;
  bool? get available => throw _privateConstructorUsedError;
  int? get end => throw _privateConstructorUsedError;
  int? get start => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AvailabilityTimeSlotCopyWith<AvailabilityTimeSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailabilityTimeSlotCopyWith<$Res> {
  factory $AvailabilityTimeSlotCopyWith(AvailabilityTimeSlot value,
          $Res Function(AvailabilityTimeSlot) then) =
      _$AvailabilityTimeSlotCopyWithImpl<$Res>;
  $Res call({String? id, bool? available, int? end, int? start});
}

/// @nodoc
class _$AvailabilityTimeSlotCopyWithImpl<$Res>
    implements $AvailabilityTimeSlotCopyWith<$Res> {
  _$AvailabilityTimeSlotCopyWithImpl(this._value, this._then);

  final AvailabilityTimeSlot _value;
  // ignore: unused_field
  final $Res Function(AvailabilityTimeSlot) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? available = freezed,
    Object? end = freezed,
    Object? start = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      available: available == freezed
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool?,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_AvailabilityTimeSlotCopyWith<$Res>
    implements $AvailabilityTimeSlotCopyWith<$Res> {
  factory _$$_AvailabilityTimeSlotCopyWith(_$_AvailabilityTimeSlot value,
          $Res Function(_$_AvailabilityTimeSlot) then) =
      __$$_AvailabilityTimeSlotCopyWithImpl<$Res>;
  @override
  $Res call({String? id, bool? available, int? end, int? start});
}

/// @nodoc
class __$$_AvailabilityTimeSlotCopyWithImpl<$Res>
    extends _$AvailabilityTimeSlotCopyWithImpl<$Res>
    implements _$$_AvailabilityTimeSlotCopyWith<$Res> {
  __$$_AvailabilityTimeSlotCopyWithImpl(_$_AvailabilityTimeSlot _value,
      $Res Function(_$_AvailabilityTimeSlot) _then)
      : super(_value, (v) => _then(v as _$_AvailabilityTimeSlot));

  @override
  _$_AvailabilityTimeSlot get _value => super._value as _$_AvailabilityTimeSlot;

  @override
  $Res call({
    Object? id = freezed,
    Object? available = freezed,
    Object? end = freezed,
    Object? start = freezed,
  }) {
    return _then(_$_AvailabilityTimeSlot(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      available: available == freezed
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool?,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AvailabilityTimeSlot extends _AvailabilityTimeSlot {
  _$_AvailabilityTimeSlot({this.id, this.available, this.end, this.start})
      : super._();

  factory _$_AvailabilityTimeSlot.fromJson(Map<String, dynamic> json) =>
      _$$_AvailabilityTimeSlotFromJson(json);

  @override
  final String? id;
  @override
  final bool? available;
  @override
  final int? end;
  @override
  final int? start;

  @override
  String toString() {
    return 'AvailabilityTimeSlot(id: $id, available: $available, end: $end, start: $start)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AvailabilityTimeSlot &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.available, available) &&
            const DeepCollectionEquality().equals(other.end, end) &&
            const DeepCollectionEquality().equals(other.start, start));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(available),
      const DeepCollectionEquality().hash(end),
      const DeepCollectionEquality().hash(start));

  @JsonKey(ignore: true)
  @override
  _$$_AvailabilityTimeSlotCopyWith<_$_AvailabilityTimeSlot> get copyWith =>
      __$$_AvailabilityTimeSlotCopyWithImpl<_$_AvailabilityTimeSlot>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AvailabilityTimeSlotToJson(
      this,
    );
  }
}

abstract class _AvailabilityTimeSlot extends AvailabilityTimeSlot {
  factory _AvailabilityTimeSlot(
      {final String? id,
      final bool? available,
      final int? end,
      final int? start}) = _$_AvailabilityTimeSlot;
  _AvailabilityTimeSlot._() : super._();

  factory _AvailabilityTimeSlot.fromJson(Map<String, dynamic> json) =
      _$_AvailabilityTimeSlot.fromJson;

  @override
  String? get id;
  @override
  bool? get available;
  @override
  int? get end;
  @override
  int? get start;
  @override
  @JsonKey(ignore: true)
  _$$_AvailabilityTimeSlotCopyWith<_$_AvailabilityTimeSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

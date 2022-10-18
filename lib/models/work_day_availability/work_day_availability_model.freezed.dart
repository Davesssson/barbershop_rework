// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'work_day_availability_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WorkDayAvailability _$WorkDayAvailabilityFromJson(Map<String, dynamic> json) {
  return _WorkDayAvailability.fromJson(json);
}

/// @nodoc
mixin _$WorkDayAvailability {
  String? get id => throw _privateConstructorUsedError;
  String? get barberId => throw _privateConstructorUsedError;
  int? get start => throw _privateConstructorUsedError;
  int? get end => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkDayAvailabilityCopyWith<WorkDayAvailability> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkDayAvailabilityCopyWith<$Res> {
  factory $WorkDayAvailabilityCopyWith(
          WorkDayAvailability value, $Res Function(WorkDayAvailability) then) =
      _$WorkDayAvailabilityCopyWithImpl<$Res>;
  $Res call({String? id, String? barberId, int? start, int? end});
}

/// @nodoc
class _$WorkDayAvailabilityCopyWithImpl<$Res>
    implements $WorkDayAvailabilityCopyWith<$Res> {
  _$WorkDayAvailabilityCopyWithImpl(this._value, this._then);

  final WorkDayAvailability _value;
  // ignore: unused_field
  final $Res Function(WorkDayAvailability) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? barberId = freezed,
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      barberId: barberId == freezed
          ? _value.barberId
          : barberId // ignore: cast_nullable_to_non_nullable
              as String?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int?,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_WorkDayAvailabilityCopyWith<$Res>
    implements $WorkDayAvailabilityCopyWith<$Res> {
  factory _$$_WorkDayAvailabilityCopyWith(_$_WorkDayAvailability value,
          $Res Function(_$_WorkDayAvailability) then) =
      __$$_WorkDayAvailabilityCopyWithImpl<$Res>;
  @override
  $Res call({String? id, String? barberId, int? start, int? end});
}

/// @nodoc
class __$$_WorkDayAvailabilityCopyWithImpl<$Res>
    extends _$WorkDayAvailabilityCopyWithImpl<$Res>
    implements _$$_WorkDayAvailabilityCopyWith<$Res> {
  __$$_WorkDayAvailabilityCopyWithImpl(_$_WorkDayAvailability _value,
      $Res Function(_$_WorkDayAvailability) _then)
      : super(_value, (v) => _then(v as _$_WorkDayAvailability));

  @override
  _$_WorkDayAvailability get _value => super._value as _$_WorkDayAvailability;

  @override
  $Res call({
    Object? id = freezed,
    Object? barberId = freezed,
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_$_WorkDayAvailability(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      barberId: barberId == freezed
          ? _value.barberId
          : barberId // ignore: cast_nullable_to_non_nullable
              as String?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int?,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WorkDayAvailability extends _WorkDayAvailability {
  _$_WorkDayAvailability({this.id, this.barberId, this.start, this.end})
      : super._();

  factory _$_WorkDayAvailability.fromJson(Map<String, dynamic> json) =>
      _$$_WorkDayAvailabilityFromJson(json);

  @override
  final String? id;
  @override
  final String? barberId;
  @override
  final int? start;
  @override
  final int? end;

  @override
  String toString() {
    return 'WorkDayAvailability(id: $id, barberId: $barberId, start: $start, end: $end)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WorkDayAvailability &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.barberId, barberId) &&
            const DeepCollectionEquality().equals(other.start, start) &&
            const DeepCollectionEquality().equals(other.end, end));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(barberId),
      const DeepCollectionEquality().hash(start),
      const DeepCollectionEquality().hash(end));

  @JsonKey(ignore: true)
  @override
  _$$_WorkDayAvailabilityCopyWith<_$_WorkDayAvailability> get copyWith =>
      __$$_WorkDayAvailabilityCopyWithImpl<_$_WorkDayAvailability>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WorkDayAvailabilityToJson(
      this,
    );
  }
}

abstract class _WorkDayAvailability extends WorkDayAvailability {
  factory _WorkDayAvailability(
      {final String? id,
      final String? barberId,
      final int? start,
      final int? end}) = _$_WorkDayAvailability;
  _WorkDayAvailability._() : super._();

  factory _WorkDayAvailability.fromJson(Map<String, dynamic> json) =
      _$_WorkDayAvailability.fromJson;

  @override
  String? get id;
  @override
  String? get barberId;
  @override
  int? get start;
  @override
  int? get end;
  @override
  @JsonKey(ignore: true)
  _$$_WorkDayAvailabilityCopyWith<_$_WorkDayAvailability> get copyWith =>
      throw _privateConstructorUsedError;
}

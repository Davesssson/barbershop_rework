// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'explorer_object_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Explorer_object _$Explorer_objectFromJson(Map<String, dynamic> json) {
  return _Explorer_object.fromJson(json);
}

/// @nodoc
mixin _$Explorer_object {
  String? get barber_name => throw _privateConstructorUsedError;
  String? get barbershop_id => throw _privateConstructorUsedError;
  String? get work_url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Explorer_objectCopyWith<Explorer_object> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Explorer_objectCopyWith<$Res> {
  factory $Explorer_objectCopyWith(
          Explorer_object value, $Res Function(Explorer_object) then) =
      _$Explorer_objectCopyWithImpl<$Res>;
  $Res call({String? barber_name, String? barbershop_id, String? work_url});
}

/// @nodoc
class _$Explorer_objectCopyWithImpl<$Res>
    implements $Explorer_objectCopyWith<$Res> {
  _$Explorer_objectCopyWithImpl(this._value, this._then);

  final Explorer_object _value;
  // ignore: unused_field
  final $Res Function(Explorer_object) _then;

  @override
  $Res call({
    Object? barber_name = freezed,
    Object? barbershop_id = freezed,
    Object? work_url = freezed,
  }) {
    return _then(_value.copyWith(
      barber_name: barber_name == freezed
          ? _value.barber_name
          : barber_name // ignore: cast_nullable_to_non_nullable
              as String?,
      barbershop_id: barbershop_id == freezed
          ? _value.barbershop_id
          : barbershop_id // ignore: cast_nullable_to_non_nullable
              as String?,
      work_url: work_url == freezed
          ? _value.work_url
          : work_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_Explorer_objectCopyWith<$Res>
    implements $Explorer_objectCopyWith<$Res> {
  factory _$$_Explorer_objectCopyWith(
          _$_Explorer_object value, $Res Function(_$_Explorer_object) then) =
      __$$_Explorer_objectCopyWithImpl<$Res>;
  @override
  $Res call({String? barber_name, String? barbershop_id, String? work_url});
}

/// @nodoc
class __$$_Explorer_objectCopyWithImpl<$Res>
    extends _$Explorer_objectCopyWithImpl<$Res>
    implements _$$_Explorer_objectCopyWith<$Res> {
  __$$_Explorer_objectCopyWithImpl(
      _$_Explorer_object _value, $Res Function(_$_Explorer_object) _then)
      : super(_value, (v) => _then(v as _$_Explorer_object));

  @override
  _$_Explorer_object get _value => super._value as _$_Explorer_object;

  @override
  $Res call({
    Object? barber_name = freezed,
    Object? barbershop_id = freezed,
    Object? work_url = freezed,
  }) {
    return _then(_$_Explorer_object(
      barber_name: barber_name == freezed
          ? _value.barber_name
          : barber_name // ignore: cast_nullable_to_non_nullable
              as String?,
      barbershop_id: barbershop_id == freezed
          ? _value.barbershop_id
          : barbershop_id // ignore: cast_nullable_to_non_nullable
              as String?,
      work_url: work_url == freezed
          ? _value.work_url
          : work_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Explorer_object extends _Explorer_object {
  const _$_Explorer_object(
      {this.barber_name, this.barbershop_id, this.work_url})
      : super._();

  factory _$_Explorer_object.fromJson(Map<String, dynamic> json) =>
      _$$_Explorer_objectFromJson(json);

  @override
  final String? barber_name;
  @override
  final String? barbershop_id;
  @override
  final String? work_url;

  @override
  String toString() {
    return 'Explorer_object(barber_name: $barber_name, barbershop_id: $barbershop_id, work_url: $work_url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Explorer_object &&
            const DeepCollectionEquality()
                .equals(other.barber_name, barber_name) &&
            const DeepCollectionEquality()
                .equals(other.barbershop_id, barbershop_id) &&
            const DeepCollectionEquality().equals(other.work_url, work_url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(barber_name),
      const DeepCollectionEquality().hash(barbershop_id),
      const DeepCollectionEquality().hash(work_url));

  @JsonKey(ignore: true)
  @override
  _$$_Explorer_objectCopyWith<_$_Explorer_object> get copyWith =>
      __$$_Explorer_objectCopyWithImpl<_$_Explorer_object>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_Explorer_objectToJson(
      this,
    );
  }
}

abstract class _Explorer_object extends Explorer_object {
  const factory _Explorer_object(
      {final String? barber_name,
      final String? barbershop_id,
      final String? work_url}) = _$_Explorer_object;
  const _Explorer_object._() : super._();

  factory _Explorer_object.fromJson(Map<String, dynamic> json) =
      _$_Explorer_object.fromJson;

  @override
  String? get barber_name;
  @override
  String? get barbershop_id;
  @override
  String? get work_url;
  @override
  @JsonKey(ignore: true)
  _$$_Explorer_objectCopyWith<_$_Explorer_object> get copyWith =>
      throw _privateConstructorUsedError;
}

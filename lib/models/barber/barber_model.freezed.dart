// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'barber_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Barber _$BarberFromJson(Map<String, dynamic> json) {
  return _Barber.fromJson(json);
}

/// @nodoc
mixin _$Barber {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BarberCopyWith<Barber> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarberCopyWith<$Res> {
  factory $BarberCopyWith(Barber value, $Res Function(Barber) then) =
      _$BarberCopyWithImpl<$Res>;
  $Res call({String? id, String? name});
}

/// @nodoc
class _$BarberCopyWithImpl<$Res> implements $BarberCopyWith<$Res> {
  _$BarberCopyWithImpl(this._value, this._then);

  final Barber _value;
  // ignore: unused_field
  final $Res Function(Barber) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_BarberCopyWith<$Res> implements $BarberCopyWith<$Res> {
  factory _$$_BarberCopyWith(_$_Barber value, $Res Function(_$_Barber) then) =
      __$$_BarberCopyWithImpl<$Res>;
  @override
  $Res call({String? id, String? name});
}

/// @nodoc
class __$$_BarberCopyWithImpl<$Res> extends _$BarberCopyWithImpl<$Res>
    implements _$$_BarberCopyWith<$Res> {
  __$$_BarberCopyWithImpl(_$_Barber _value, $Res Function(_$_Barber) _then)
      : super(_value, (v) => _then(v as _$_Barber));

  @override
  _$_Barber get _value => super._value as _$_Barber;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_Barber(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Barber extends _Barber with DiagnosticableTreeMixin {
  _$_Barber({this.id, this.name}) : super._();

  factory _$_Barber.fromJson(Map<String, dynamic> json) =>
      _$$_BarberFromJson(json);

  @override
  final String? id;
  @override
  final String? name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Barber(id: $id, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Barber'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Barber &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_BarberCopyWith<_$_Barber> get copyWith =>
      __$$_BarberCopyWithImpl<_$_Barber>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BarberToJson(this);
  }
}

abstract class _Barber extends Barber {
  factory _Barber({final String? id, final String? name}) = _$_Barber;
  _Barber._() : super._();

  factory _Barber.fromJson(Map<String, dynamic> json) = _$_Barber.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_BarberCopyWith<_$_Barber> get copyWith =>
      throw _privateConstructorUsedError;
}
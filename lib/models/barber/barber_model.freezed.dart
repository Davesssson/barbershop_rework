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
  String? get barbershop_id => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get prof_pic => throw _privateConstructorUsedError;
  List<String>? get works => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BarberCopyWith<Barber> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarberCopyWith<$Res> {
  factory $BarberCopyWith(Barber value, $Res Function(Barber) then) =
      _$BarberCopyWithImpl<$Res>;
  $Res call(
      {String? barbershop_id,
      String? id,
      String? name,
      String? description,
      String? prof_pic,
      List<String>? works});
}

/// @nodoc
class _$BarberCopyWithImpl<$Res> implements $BarberCopyWith<$Res> {
  _$BarberCopyWithImpl(this._value, this._then);

  final Barber _value;
  // ignore: unused_field
  final $Res Function(Barber) _then;

  @override
  $Res call({
    Object? barbershop_id = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? prof_pic = freezed,
    Object? works = freezed,
  }) {
    return _then(_value.copyWith(
      barbershop_id: barbershop_id == freezed
          ? _value.barbershop_id
          : barbershop_id // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      prof_pic: prof_pic == freezed
          ? _value.prof_pic
          : prof_pic // ignore: cast_nullable_to_non_nullable
              as String?,
      works: works == freezed
          ? _value.works
          : works // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
abstract class _$$_BarberCopyWith<$Res> implements $BarberCopyWith<$Res> {
  factory _$$_BarberCopyWith(_$_Barber value, $Res Function(_$_Barber) then) =
      __$$_BarberCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? barbershop_id,
      String? id,
      String? name,
      String? description,
      String? prof_pic,
      List<String>? works});
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
    Object? barbershop_id = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? prof_pic = freezed,
    Object? works = freezed,
  }) {
    return _then(_$_Barber(
      barbershop_id: barbershop_id == freezed
          ? _value.barbershop_id
          : barbershop_id // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      prof_pic: prof_pic == freezed
          ? _value.prof_pic
          : prof_pic // ignore: cast_nullable_to_non_nullable
              as String?,
      works: works == freezed
          ? _value._works
          : works // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Barber extends _Barber with DiagnosticableTreeMixin {
  _$_Barber(
      {this.barbershop_id,
      this.id,
      this.name,
      this.description,
      this.prof_pic,
      final List<String>? works})
      : _works = works,
        super._();

  factory _$_Barber.fromJson(Map<String, dynamic> json) =>
      _$$_BarberFromJson(json);

  @override
  final String? barbershop_id;
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? prof_pic;
  final List<String>? _works;
  @override
  List<String>? get works {
    final value = _works;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Barber(barbershop_id: $barbershop_id, id: $id, name: $name, description: $description, prof_pic: $prof_pic, works: $works)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Barber'))
      ..add(DiagnosticsProperty('barbershop_id', barbershop_id))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('prof_pic', prof_pic))
      ..add(DiagnosticsProperty('works', works));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Barber &&
            const DeepCollectionEquality()
                .equals(other.barbershop_id, barbershop_id) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.prof_pic, prof_pic) &&
            const DeepCollectionEquality().equals(other._works, _works));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(barbershop_id),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(prof_pic),
      const DeepCollectionEquality().hash(_works));

  @JsonKey(ignore: true)
  @override
  _$$_BarberCopyWith<_$_Barber> get copyWith =>
      __$$_BarberCopyWithImpl<_$_Barber>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BarberToJson(
      this,
    );
  }
}

abstract class _Barber extends Barber {
  factory _Barber(
      {final String? barbershop_id,
      final String? id,
      final String? name,
      final String? description,
      final String? prof_pic,
      final List<String>? works}) = _$_Barber;
  _Barber._() : super._();

  factory _Barber.fromJson(Map<String, dynamic> json) = _$_Barber.fromJson;

  @override
  String? get barbershop_id;
  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  String? get prof_pic;
  @override
  List<String>? get works;
  @override
  @JsonKey(ignore: true)
  _$$_BarberCopyWith<_$_Barber> get copyWith =>
      throw _privateConstructorUsedError;
}

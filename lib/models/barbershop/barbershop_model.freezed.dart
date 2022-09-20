// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'barbershop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Barbershop _$BarbershopFromJson(Map<String, dynamic> json) {
  return _Barbershop.fromJson(json);
}

/// @nodoc
mixin _$Barbershop {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get main_image => throw _privateConstructorUsedError;
  @CustomGeoPointConverter()
  GeoPoint get location => throw _privateConstructorUsedError;
  String? get places_id => throw _privateConstructorUsedError;
  List<String>? get barbers => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  List<String>? get services => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BarbershopCopyWith<Barbershop> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarbershopCopyWith<$Res> {
  factory $BarbershopCopyWith(
          Barbershop value, $Res Function(Barbershop) then) =
      _$BarbershopCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? name,
      String? main_image,
      @CustomGeoPointConverter() GeoPoint location,
      String? places_id,
      List<String>? barbers,
      String? city,
      List<String>? services});
}

/// @nodoc
class _$BarbershopCopyWithImpl<$Res> implements $BarbershopCopyWith<$Res> {
  _$BarbershopCopyWithImpl(this._value, this._then);

  final Barbershop _value;
  // ignore: unused_field
  final $Res Function(Barbershop) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? main_image = freezed,
    Object? location = freezed,
    Object? places_id = freezed,
    Object? barbers = freezed,
    Object? city = freezed,
    Object? services = freezed,
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
      main_image: main_image == freezed
          ? _value.main_image
          : main_image // ignore: cast_nullable_to_non_nullable
              as String?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      places_id: places_id == freezed
          ? _value.places_id
          : places_id // ignore: cast_nullable_to_non_nullable
              as String?,
      barbers: barbers == freezed
          ? _value.barbers
          : barbers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      services: services == freezed
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
abstract class _$$_BarbershopCopyWith<$Res>
    implements $BarbershopCopyWith<$Res> {
  factory _$$_BarbershopCopyWith(
          _$_Barbershop value, $Res Function(_$_Barbershop) then) =
      __$$_BarbershopCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? name,
      String? main_image,
      @CustomGeoPointConverter() GeoPoint location,
      String? places_id,
      List<String>? barbers,
      String? city,
      List<String>? services});
}

/// @nodoc
class __$$_BarbershopCopyWithImpl<$Res> extends _$BarbershopCopyWithImpl<$Res>
    implements _$$_BarbershopCopyWith<$Res> {
  __$$_BarbershopCopyWithImpl(
      _$_Barbershop _value, $Res Function(_$_Barbershop) _then)
      : super(_value, (v) => _then(v as _$_Barbershop));

  @override
  _$_Barbershop get _value => super._value as _$_Barbershop;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? main_image = freezed,
    Object? location = freezed,
    Object? places_id = freezed,
    Object? barbers = freezed,
    Object? city = freezed,
    Object? services = freezed,
  }) {
    return _then(_$_Barbershop(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      main_image: main_image == freezed
          ? _value.main_image
          : main_image // ignore: cast_nullable_to_non_nullable
              as String?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      places_id: places_id == freezed
          ? _value.places_id
          : places_id // ignore: cast_nullable_to_non_nullable
              as String?,
      barbers: barbers == freezed
          ? _value._barbers
          : barbers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      services: services == freezed
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Barbershop extends _Barbershop {
  _$_Barbershop(
      {this.id,
      this.name,
      this.main_image,
      @CustomGeoPointConverter() required this.location,
      this.places_id,
      final List<String>? barbers,
      this.city,
      final List<String>? services})
      : _barbers = barbers,
        _services = services,
        super._();

  factory _$_Barbershop.fromJson(Map<String, dynamic> json) =>
      _$$_BarbershopFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? main_image;
  @override
  @CustomGeoPointConverter()
  final GeoPoint location;
  @override
  final String? places_id;
  final List<String>? _barbers;
  @override
  List<String>? get barbers {
    final value = _barbers;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? city;
  final List<String>? _services;
  @override
  List<String>? get services {
    final value = _services;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Barbershop(id: $id, name: $name, main_image: $main_image, location: $location, places_id: $places_id, barbers: $barbers, city: $city, services: $services)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Barbershop &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.main_image, main_image) &&
            const DeepCollectionEquality().equals(other.location, location) &&
            const DeepCollectionEquality().equals(other.places_id, places_id) &&
            const DeepCollectionEquality().equals(other._barbers, _barbers) &&
            const DeepCollectionEquality().equals(other.city, city) &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(main_image),
      const DeepCollectionEquality().hash(location),
      const DeepCollectionEquality().hash(places_id),
      const DeepCollectionEquality().hash(_barbers),
      const DeepCollectionEquality().hash(city),
      const DeepCollectionEquality().hash(_services));

  @JsonKey(ignore: true)
  @override
  _$$_BarbershopCopyWith<_$_Barbershop> get copyWith =>
      __$$_BarbershopCopyWithImpl<_$_Barbershop>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BarbershopToJson(
      this,
    );
  }
}

abstract class _Barbershop extends Barbershop {
  factory _Barbershop(
      {final String? id,
      final String? name,
      final String? main_image,
      @CustomGeoPointConverter() required final GeoPoint location,
      final String? places_id,
      final List<String>? barbers,
      final String? city,
      final List<String>? services}) = _$_Barbershop;
  _Barbershop._() : super._();

  factory _Barbershop.fromJson(Map<String, dynamic> json) =
      _$_Barbershop.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get main_image;
  @override
  @CustomGeoPointConverter()
  GeoPoint get location;
  @override
  String? get places_id;
  @override
  List<String>? get barbers;
  @override
  String? get city;
  @override
  List<String>? get services;
  @override
  @JsonKey(ignore: true)
  _$$_BarbershopCopyWith<_$_Barbershop> get copyWith =>
      throw _privateConstructorUsedError;
}

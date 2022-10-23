// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return _Service.fromJson(json);
}

/// @nodoc
mixin _$Service {
  String? get id => throw _privateConstructorUsedError;
  String? get serviceTitle => throw _privateConstructorUsedError;
  int? get servicePrice => throw _privateConstructorUsedError;
  String? get serviceDescription => throw _privateConstructorUsedError;
  String? get barbershop_id => throw _privateConstructorUsedError;
  Map<String, dynamic>? get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceCopyWith<Service> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceCopyWith<$Res> {
  factory $ServiceCopyWith(Service value, $Res Function(Service) then) =
      _$ServiceCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? serviceTitle,
      int? servicePrice,
      String? serviceDescription,
      String? barbershop_id,
      Map<String, dynamic>? tags});
}

/// @nodoc
class _$ServiceCopyWithImpl<$Res> implements $ServiceCopyWith<$Res> {
  _$ServiceCopyWithImpl(this._value, this._then);

  final Service _value;
  // ignore: unused_field
  final $Res Function(Service) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? serviceTitle = freezed,
    Object? servicePrice = freezed,
    Object? serviceDescription = freezed,
    Object? barbershop_id = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceTitle: serviceTitle == freezed
          ? _value.serviceTitle
          : serviceTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      servicePrice: servicePrice == freezed
          ? _value.servicePrice
          : servicePrice // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceDescription: serviceDescription == freezed
          ? _value.serviceDescription
          : serviceDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      barbershop_id: barbershop_id == freezed
          ? _value.barbershop_id
          : barbershop_id // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
abstract class _$$_ServiceCopyWith<$Res> implements $ServiceCopyWith<$Res> {
  factory _$$_ServiceCopyWith(
          _$_Service value, $Res Function(_$_Service) then) =
      __$$_ServiceCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? serviceTitle,
      int? servicePrice,
      String? serviceDescription,
      String? barbershop_id,
      Map<String, dynamic>? tags});
}

/// @nodoc
class __$$_ServiceCopyWithImpl<$Res> extends _$ServiceCopyWithImpl<$Res>
    implements _$$_ServiceCopyWith<$Res> {
  __$$_ServiceCopyWithImpl(_$_Service _value, $Res Function(_$_Service) _then)
      : super(_value, (v) => _then(v as _$_Service));

  @override
  _$_Service get _value => super._value as _$_Service;

  @override
  $Res call({
    Object? id = freezed,
    Object? serviceTitle = freezed,
    Object? servicePrice = freezed,
    Object? serviceDescription = freezed,
    Object? barbershop_id = freezed,
    Object? tags = freezed,
  }) {
    return _then(_$_Service(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceTitle: serviceTitle == freezed
          ? _value.serviceTitle
          : serviceTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      servicePrice: servicePrice == freezed
          ? _value.servicePrice
          : servicePrice // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceDescription: serviceDescription == freezed
          ? _value.serviceDescription
          : serviceDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      barbershop_id: barbershop_id == freezed
          ? _value.barbershop_id
          : barbershop_id // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: tags == freezed
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Service extends _Service {
  _$_Service(
      {this.id,
      this.serviceTitle,
      this.servicePrice,
      this.serviceDescription,
      this.barbershop_id,
      final Map<String, dynamic>? tags})
      : _tags = tags,
        super._();

  factory _$_Service.fromJson(Map<String, dynamic> json) =>
      _$$_ServiceFromJson(json);

  @override
  final String? id;
  @override
  final String? serviceTitle;
  @override
  final int? servicePrice;
  @override
  final String? serviceDescription;
  @override
  final String? barbershop_id;
  final Map<String, dynamic>? _tags;
  @override
  Map<String, dynamic>? get tags {
    final value = _tags;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Service(id: $id, serviceTitle: $serviceTitle, servicePrice: $servicePrice, serviceDescription: $serviceDescription, barbershop_id: $barbershop_id, tags: $tags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Service &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.serviceTitle, serviceTitle) &&
            const DeepCollectionEquality()
                .equals(other.servicePrice, servicePrice) &&
            const DeepCollectionEquality()
                .equals(other.serviceDescription, serviceDescription) &&
            const DeepCollectionEquality()
                .equals(other.barbershop_id, barbershop_id) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(serviceTitle),
      const DeepCollectionEquality().hash(servicePrice),
      const DeepCollectionEquality().hash(serviceDescription),
      const DeepCollectionEquality().hash(barbershop_id),
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  _$$_ServiceCopyWith<_$_Service> get copyWith =>
      __$$_ServiceCopyWithImpl<_$_Service>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ServiceToJson(
      this,
    );
  }
}

abstract class _Service extends Service {
  factory _Service(
      {final String? id,
      final String? serviceTitle,
      final int? servicePrice,
      final String? serviceDescription,
      final String? barbershop_id,
      final Map<String, dynamic>? tags}) = _$_Service;
  _Service._() : super._();

  factory _Service.fromJson(Map<String, dynamic> json) = _$_Service.fromJson;

  @override
  String? get id;
  @override
  String? get serviceTitle;
  @override
  int? get servicePrice;
  @override
  String? get serviceDescription;
  @override
  String? get barbershop_id;
  @override
  Map<String, dynamic>? get tags;
  @override
  @JsonKey(ignore: true)
  _$$_ServiceCopyWith<_$_Service> get copyWith =>
      throw _privateConstructorUsedError;
}

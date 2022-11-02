// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return _Booking.fromJson(json);
}

/// @nodoc
mixin _$Booking {
  String? get dateId => throw _privateConstructorUsedError;
  String? get uId => throw _privateConstructorUsedError;
  String? get barberId => throw _privateConstructorUsedError;
  int? get start => throw _privateConstructorUsedError;
  int? get end => throw _privateConstructorUsedError;
  String? get userReserverId => throw _privateConstructorUsedError;
  String? get serviceId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookingCopyWith<Booking> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingCopyWith<$Res> {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) then) =
      _$BookingCopyWithImpl<$Res>;
  $Res call(
      {String? dateId,
      String? uId,
      String? barberId,
      int? start,
      int? end,
      String? userReserverId,
      String? serviceId});
}

/// @nodoc
class _$BookingCopyWithImpl<$Res> implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._value, this._then);

  final Booking _value;
  // ignore: unused_field
  final $Res Function(Booking) _then;

  @override
  $Res call({
    Object? dateId = freezed,
    Object? uId = freezed,
    Object? barberId = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? userReserverId = freezed,
    Object? serviceId = freezed,
  }) {
    return _then(_value.copyWith(
      dateId: dateId == freezed
          ? _value.dateId
          : dateId // ignore: cast_nullable_to_non_nullable
              as String?,
      uId: uId == freezed
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
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
      userReserverId: userReserverId == freezed
          ? _value.userReserverId
          : userReserverId // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceId: serviceId == freezed
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_BookingCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$$_BookingCopyWith(
          _$_Booking value, $Res Function(_$_Booking) then) =
      __$$_BookingCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? dateId,
      String? uId,
      String? barberId,
      int? start,
      int? end,
      String? userReserverId,
      String? serviceId});
}

/// @nodoc
class __$$_BookingCopyWithImpl<$Res> extends _$BookingCopyWithImpl<$Res>
    implements _$$_BookingCopyWith<$Res> {
  __$$_BookingCopyWithImpl(_$_Booking _value, $Res Function(_$_Booking) _then)
      : super(_value, (v) => _then(v as _$_Booking));

  @override
  _$_Booking get _value => super._value as _$_Booking;

  @override
  $Res call({
    Object? dateId = freezed,
    Object? uId = freezed,
    Object? barberId = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? userReserverId = freezed,
    Object? serviceId = freezed,
  }) {
    return _then(_$_Booking(
      dateId: dateId == freezed
          ? _value.dateId
          : dateId // ignore: cast_nullable_to_non_nullable
              as String?,
      uId: uId == freezed
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
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
      userReserverId: userReserverId == freezed
          ? _value.userReserverId
          : userReserverId // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceId: serviceId == freezed
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Booking extends _Booking {
  _$_Booking(
      {this.dateId,
      this.uId,
      this.barberId,
      this.start,
      this.end,
      this.userReserverId,
      this.serviceId})
      : super._();

  factory _$_Booking.fromJson(Map<String, dynamic> json) =>
      _$$_BookingFromJson(json);

  @override
  final String? dateId;
  @override
  final String? uId;
  @override
  final String? barberId;
  @override
  final int? start;
  @override
  final int? end;
  @override
  final String? userReserverId;
  @override
  final String? serviceId;

  @override
  String toString() {
    return 'Booking(dateId: $dateId, uId: $uId, barberId: $barberId, start: $start, end: $end, userReserverId: $userReserverId, serviceId: $serviceId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Booking &&
            const DeepCollectionEquality().equals(other.dateId, dateId) &&
            const DeepCollectionEquality().equals(other.uId, uId) &&
            const DeepCollectionEquality().equals(other.barberId, barberId) &&
            const DeepCollectionEquality().equals(other.start, start) &&
            const DeepCollectionEquality().equals(other.end, end) &&
            const DeepCollectionEquality()
                .equals(other.userReserverId, userReserverId) &&
            const DeepCollectionEquality().equals(other.serviceId, serviceId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(dateId),
      const DeepCollectionEquality().hash(uId),
      const DeepCollectionEquality().hash(barberId),
      const DeepCollectionEquality().hash(start),
      const DeepCollectionEquality().hash(end),
      const DeepCollectionEquality().hash(userReserverId),
      const DeepCollectionEquality().hash(serviceId));

  @JsonKey(ignore: true)
  @override
  _$$_BookingCopyWith<_$_Booking> get copyWith =>
      __$$_BookingCopyWithImpl<_$_Booking>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookingToJson(
      this,
    );
  }
}

abstract class _Booking extends Booking {
  factory _Booking(
      {final String? dateId,
      final String? uId,
      final String? barberId,
      final int? start,
      final int? end,
      final String? userReserverId,
      final String? serviceId}) = _$_Booking;
  _Booking._() : super._();

  factory _Booking.fromJson(Map<String, dynamic> json) = _$_Booking.fromJson;

  @override
  String? get dateId;
  @override
  String? get uId;
  @override
  String? get barberId;
  @override
  int? get start;
  @override
  int? get end;
  @override
  String? get userReserverId;
  @override
  String? get serviceId;
  @override
  @JsonKey(ignore: true)
  _$$_BookingCopyWith<_$_Booking> get copyWith =>
      throw _privateConstructorUsedError;
}

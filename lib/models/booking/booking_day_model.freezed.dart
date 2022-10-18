// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'booking_day_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BookingDay _$BookingDayFromJson(Map<String, dynamic> json) {
  return _BookingDay.fromJson(json);
}

/// @nodoc
mixin _$BookingDay {
  String? get id => throw _privateConstructorUsedError;
  List<Booking>? get bookings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookingDayCopyWith<BookingDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingDayCopyWith<$Res> {
  factory $BookingDayCopyWith(
          BookingDay value, $Res Function(BookingDay) then) =
      _$BookingDayCopyWithImpl<$Res>;
  $Res call({String? id, List<Booking>? bookings});
}

/// @nodoc
class _$BookingDayCopyWithImpl<$Res> implements $BookingDayCopyWith<$Res> {
  _$BookingDayCopyWithImpl(this._value, this._then);

  final BookingDay _value;
  // ignore: unused_field
  final $Res Function(BookingDay) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? bookings = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      bookings: bookings == freezed
          ? _value.bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<Booking>?,
    ));
  }
}

/// @nodoc
abstract class _$$_BookingDayCopyWith<$Res>
    implements $BookingDayCopyWith<$Res> {
  factory _$$_BookingDayCopyWith(
          _$_BookingDay value, $Res Function(_$_BookingDay) then) =
      __$$_BookingDayCopyWithImpl<$Res>;
  @override
  $Res call({String? id, List<Booking>? bookings});
}

/// @nodoc
class __$$_BookingDayCopyWithImpl<$Res> extends _$BookingDayCopyWithImpl<$Res>
    implements _$$_BookingDayCopyWith<$Res> {
  __$$_BookingDayCopyWithImpl(
      _$_BookingDay _value, $Res Function(_$_BookingDay) _then)
      : super(_value, (v) => _then(v as _$_BookingDay));

  @override
  _$_BookingDay get _value => super._value as _$_BookingDay;

  @override
  $Res call({
    Object? id = freezed,
    Object? bookings = freezed,
  }) {
    return _then(_$_BookingDay(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      bookings: bookings == freezed
          ? _value._bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<Booking>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BookingDay extends _BookingDay {
  _$_BookingDay({this.id, final List<Booking>? bookings})
      : _bookings = bookings,
        super._();

  factory _$_BookingDay.fromJson(Map<String, dynamic> json) =>
      _$$_BookingDayFromJson(json);

  @override
  final String? id;
  final List<Booking>? _bookings;
  @override
  List<Booking>? get bookings {
    final value = _bookings;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'BookingDay(id: $id, bookings: $bookings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BookingDay &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other._bookings, _bookings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(_bookings));

  @JsonKey(ignore: true)
  @override
  _$$_BookingDayCopyWith<_$_BookingDay> get copyWith =>
      __$$_BookingDayCopyWithImpl<_$_BookingDay>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookingDayToJson(
      this,
    );
  }
}

abstract class _BookingDay extends BookingDay {
  factory _BookingDay({final String? id, final List<Booking>? bookings}) =
      _$_BookingDay;
  _BookingDay._() : super._();

  factory _BookingDay.fromJson(Map<String, dynamic> json) =
      _$_BookingDay.fromJson;

  @override
  String? get id;
  @override
  List<Booking>? get bookings;
  @override
  @JsonKey(ignore: true)
  _$$_BookingDayCopyWith<_$_BookingDay> get copyWith =>
      throw _privateConstructorUsedError;
}

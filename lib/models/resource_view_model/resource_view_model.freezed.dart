// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'resource_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ResourceViewModel _$ResourceViewModelFromJson(Map<String, dynamic> json) {
  return _ResourceViewModel.fromJson(json);
}

/// @nodoc
mixin _$ResourceViewModel {
  Barber? get barber => throw _privateConstructorUsedError;
  List<WorkDayAvailability>? get workDayAvailability =>
      throw _privateConstructorUsedError;
  List<BookingDay>? get bookings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResourceViewModelCopyWith<ResourceViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResourceViewModelCopyWith<$Res> {
  factory $ResourceViewModelCopyWith(
          ResourceViewModel value, $Res Function(ResourceViewModel) then) =
      _$ResourceViewModelCopyWithImpl<$Res>;
  $Res call(
      {Barber? barber,
      List<WorkDayAvailability>? workDayAvailability,
      List<BookingDay>? bookings});

  $BarberCopyWith<$Res>? get barber;
}

/// @nodoc
class _$ResourceViewModelCopyWithImpl<$Res>
    implements $ResourceViewModelCopyWith<$Res> {
  _$ResourceViewModelCopyWithImpl(this._value, this._then);

  final ResourceViewModel _value;
  // ignore: unused_field
  final $Res Function(ResourceViewModel) _then;

  @override
  $Res call({
    Object? barber = freezed,
    Object? workDayAvailability = freezed,
    Object? bookings = freezed,
  }) {
    return _then(_value.copyWith(
      barber: barber == freezed
          ? _value.barber
          : barber // ignore: cast_nullable_to_non_nullable
              as Barber?,
      workDayAvailability: workDayAvailability == freezed
          ? _value.workDayAvailability
          : workDayAvailability // ignore: cast_nullable_to_non_nullable
              as List<WorkDayAvailability>?,
      bookings: bookings == freezed
          ? _value.bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<BookingDay>?,
    ));
  }

  @override
  $BarberCopyWith<$Res>? get barber {
    if (_value.barber == null) {
      return null;
    }

    return $BarberCopyWith<$Res>(_value.barber!, (value) {
      return _then(_value.copyWith(barber: value));
    });
  }
}

/// @nodoc
abstract class _$$_ResourceViewModelCopyWith<$Res>
    implements $ResourceViewModelCopyWith<$Res> {
  factory _$$_ResourceViewModelCopyWith(_$_ResourceViewModel value,
          $Res Function(_$_ResourceViewModel) then) =
      __$$_ResourceViewModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {Barber? barber,
      List<WorkDayAvailability>? workDayAvailability,
      List<BookingDay>? bookings});

  @override
  $BarberCopyWith<$Res>? get barber;
}

/// @nodoc
class __$$_ResourceViewModelCopyWithImpl<$Res>
    extends _$ResourceViewModelCopyWithImpl<$Res>
    implements _$$_ResourceViewModelCopyWith<$Res> {
  __$$_ResourceViewModelCopyWithImpl(
      _$_ResourceViewModel _value, $Res Function(_$_ResourceViewModel) _then)
      : super(_value, (v) => _then(v as _$_ResourceViewModel));

  @override
  _$_ResourceViewModel get _value => super._value as _$_ResourceViewModel;

  @override
  $Res call({
    Object? barber = freezed,
    Object? workDayAvailability = freezed,
    Object? bookings = freezed,
  }) {
    return _then(_$_ResourceViewModel(
      barber: barber == freezed
          ? _value.barber
          : barber // ignore: cast_nullable_to_non_nullable
              as Barber?,
      workDayAvailability: workDayAvailability == freezed
          ? _value._workDayAvailability
          : workDayAvailability // ignore: cast_nullable_to_non_nullable
              as List<WorkDayAvailability>?,
      bookings: bookings == freezed
          ? _value._bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<BookingDay>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ResourceViewModel extends _ResourceViewModel {
  _$_ResourceViewModel(
      {this.barber,
      final List<WorkDayAvailability>? workDayAvailability,
      final List<BookingDay>? bookings})
      : _workDayAvailability = workDayAvailability,
        _bookings = bookings,
        super._();

  factory _$_ResourceViewModel.fromJson(Map<String, dynamic> json) =>
      _$$_ResourceViewModelFromJson(json);

  @override
  final Barber? barber;
  final List<WorkDayAvailability>? _workDayAvailability;
  @override
  List<WorkDayAvailability>? get workDayAvailability {
    final value = _workDayAvailability;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<BookingDay>? _bookings;
  @override
  List<BookingDay>? get bookings {
    final value = _bookings;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ResourceViewModel(barber: $barber, workDayAvailability: $workDayAvailability, bookings: $bookings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ResourceViewModel &&
            const DeepCollectionEquality().equals(other.barber, barber) &&
            const DeepCollectionEquality()
                .equals(other._workDayAvailability, _workDayAvailability) &&
            const DeepCollectionEquality().equals(other._bookings, _bookings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(barber),
      const DeepCollectionEquality().hash(_workDayAvailability),
      const DeepCollectionEquality().hash(_bookings));

  @JsonKey(ignore: true)
  @override
  _$$_ResourceViewModelCopyWith<_$_ResourceViewModel> get copyWith =>
      __$$_ResourceViewModelCopyWithImpl<_$_ResourceViewModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ResourceViewModelToJson(
      this,
    );
  }
}

abstract class _ResourceViewModel extends ResourceViewModel {
  factory _ResourceViewModel(
      {final Barber? barber,
      final List<WorkDayAvailability>? workDayAvailability,
      final List<BookingDay>? bookings}) = _$_ResourceViewModel;
  _ResourceViewModel._() : super._();

  factory _ResourceViewModel.fromJson(Map<String, dynamic> json) =
      _$_ResourceViewModel.fromJson;

  @override
  Barber? get barber;
  @override
  List<WorkDayAvailability>? get workDayAvailability;
  @override
  List<BookingDay>? get bookings;
  @override
  @JsonKey(ignore: true)
  _$$_ResourceViewModelCopyWith<_$_ResourceViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

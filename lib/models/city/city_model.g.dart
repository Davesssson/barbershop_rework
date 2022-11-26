// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_City _$$_CityFromJson(Map<String, dynamic> json) => _$_City(
      id: json['id'] as String?,
      cityName: json['cityName'] as String?,
      location: _$JsonConverterFromJson<Map<String, dynamic>, GeoPoint>(
          json['location'], const CustomGeoPointConverter().fromJson),
    );

Map<String, dynamic> _$$_CityToJson(_$_City instance) => <String, dynamic>{
      'id': instance.id,
      'cityName': instance.cityName,
      'location': _$JsonConverterToJson<Map<String, dynamic>, GeoPoint>(
          instance.location, const CustomGeoPointConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barbershop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Barbershop _$$_BarbershopFromJson(Map<String, dynamic> json) =>
    _$_Barbershop(
      id: json['id'] as String?,
      name: json['name'] as String?,
      main_image: json['main_image'] as String?,
      location: const CustomGeoPointConverter()
          .fromJson(json['location'] as Map<String, dynamic>),
      places_id: json['places_id'] as String?,
    );

Map<String, dynamic> _$$_BarbershopToJson(_$_Barbershop instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'main_image': instance.main_image,
      'location': const CustomGeoPointConverter().toJson(instance.location),
      'places_id': instance.places_id,
    };

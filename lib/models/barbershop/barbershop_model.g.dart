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
      barbers:
          (json['barbers'] as List<dynamic>?)?.map((e) => e as String).toList(),
      city: json['city'] as String?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isVisible: json['isVisible'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$$_BarbershopToJson(_$_Barbershop instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'main_image': instance.main_image,
      'location': const CustomGeoPointConverter().toJson(instance.location),
      'places_id': instance.places_id,
      'barbers': instance.barbers,
      'city': instance.city,
      'services': instance.services,
      'tags': instance.tags,
      'isVisible': instance.isVisible,
      'isDeleted': instance.isDeleted,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Availability _$$_AvailabilityFromJson(Map<String, dynamic> json) =>
    _$_Availability(
      barbershop_id: json['barbershop_id'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      prof_pic: json['prof_pic'] as String?,
      works:
          (json['works'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_AvailabilityToJson(_$_Availability instance) =>
    <String, dynamic>{
      'barbershop_id': instance.barbershop_id,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'prof_pic': instance.prof_pic,
      'works': instance.works,
    };

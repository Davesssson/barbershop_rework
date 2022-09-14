// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barber_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Barber _$$_BarberFromJson(Map<String, dynamic> json) => _$_Barber(
      barbershop_id: json['barbershop_id'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      prof_pic: json['prof_pic'] as String?,
      works:
          (json['works'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_BarberToJson(_$_Barber instance) => <String, dynamic>{
      'barbershop_id': instance.barbershop_id,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'prof_pic': instance.prof_pic,
      'works': instance.works,
    };

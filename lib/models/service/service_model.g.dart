// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Service _$$_ServiceFromJson(Map<String, dynamic> json) => _$_Service(
      id: json['id'] as String?,
      serviceTitle: json['serviceTitle'] as String?,
      servicePrice: json['servicePrice'] as int?,
      serviceDescription: json['serviceDescription'] as String?,
    );

Map<String, dynamic> _$$_ServiceToJson(_$_Service instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceTitle': instance.serviceTitle,
      'servicePrice': instance.servicePrice,
      'serviceDescription': instance.serviceDescription,
    };

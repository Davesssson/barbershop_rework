import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converter.dart';

part 'explorer_object_model.freezed.dart';
part 'explorer_object_model.g.dart';

@freezed
class Explorer_object with _$Explorer_object {
  const Explorer_object._();

  const factory Explorer_object({
    String? barber_name,
    String? barbershop_id,
    String? work_url,
  }) = _Explorer_object;

  factory Explorer_object.fromJson(Map<String, dynamic> json) => _$Explorer_objectFromJson(json);

  factory Explorer_object.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String,dynamic>;
    data['location']=CustomGeoPointConverter().toJson(doc.get('location'));
    return Explorer_object.fromJson(data as Map<String,dynamic>);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}

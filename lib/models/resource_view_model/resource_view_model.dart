import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shopping_list/models/work_day_availability/work_day_availability_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../barber/barber_model.dart';
import '../booking/booking_day_model.dart';
import '../booking/booking_model.dart';

part 'resource_view_model.freezed.dart';
part 'resource_view_model.g.dart';

@freezed
class ResourceViewModel with _$ResourceViewModel{
  const ResourceViewModel._();

  factory ResourceViewModel({
    Barber? barber,
    List<WorkDayAvailability>? workDayAvailability,
    List<BookingDay>? bookings,
  })= _ResourceViewModel;

  factory ResourceViewModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()!;
    return ResourceViewModel.fromJson(data as Map<String,dynamic>);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');

  factory ResourceViewModel.fromJson(Map<String, dynamic> json) => _$ResourceViewModelFromJson(json);
}
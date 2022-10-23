import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/repositories/booking_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/barber/barber_model.dart';
import '../../models/booking/booking_model.dart';

final retrieveBookingsForUserProvider = FutureProvider.family<List<Booking>,String>((ref,userId) async {
  final bookings = await ref.read(BookingRepositoryProvider).retrieveBookingsForUser(userId:userId);
  print("bookings.tostring"+bookings.toString());
  return bookings;
});
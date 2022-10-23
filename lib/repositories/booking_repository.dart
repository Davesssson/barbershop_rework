import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shopping_list/extensions/firebase_firestore_extension.dart';
import 'package:flutter_shopping_list/general_providers.dart';
import 'package:flutter_shopping_list/models/item/item_model.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;

import '../models/booking/booking_model.dart';

abstract class BaseBookingRepository {

}

final BookingRepositoryProvider = Provider<BookingRepository>((ref) => BookingRepository(ref.read));

class BookingRepository implements BaseBookingRepository {
  final Reader _read;

  const BookingRepository(this._read);

  Future<void> addBooking({
    required Booking booking,
  }) async {
    developer.log("[booking_repository.dart][BookingRepository][addBooking] - addBooking");
    try {
      await _read(firebaseFirestoreProvider)
          .collection('bookings')
          .doc(booking.uId)
          .set(booking.toJson());
    } on FirebaseException catch (e) {
      developer.log("[booking_repository.dart][BookingRepository][addBooking] - addBooking exception");
      throw CustomException(message: e.message);
    }
  }

  Future<List<Booking>> retrieveBookingsForUser({
    required String userId,
  }) async {
    developer.log("[booking_repository.dart][BookingRepository][addBooking] - addBooking");
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .collection('bookings')
          .where('userReserverId',isEqualTo: userId)
          .get();
      return snap.docs.map((oneBooking) => Booking.fromDocument(oneBooking)).toList();
    } on FirebaseException catch (e) {
      developer.log("[booking_repository.dart][BookingRepository][addBooking] - addBooking exception");
      throw CustomException(message: e.message);
    }
  }
}

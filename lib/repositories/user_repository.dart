import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;

import '../models/booking/booking_model.dart';


abstract class BaseUsersRepository {
  //Future<void> addUser({UserCredential result});
}

final userRepositoryProvider = Provider<UsersRepository>((ref) => UsersRepository(ref.read));

class UsersRepository implements BaseUsersRepository{
  final Reader _reader;

  const UsersRepository(this._reader);

  Future<void> addUser(UserCredential result,{String role = "customer" })async{
    try {
      developer.log("[user_repository.dart][UsersRepository][addUser] - User added.");
      User user = result.user!;
      //TODO outsource the .set method
      await FirebaseFirestore.instance.collection('users').doc(user.uid)
          .set({
            'firstName': 'Placeholder',
            'bookings':{},
            'role':role
          });
    }on FirebaseAuthException catch(e){
      developer.log("[user_repository.dart][UsersRepository][addUser] - User add Exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<void> addBookingToUser(User user, String bookingId)async{
    try {
      developer.log("[user_repository.dart][UsersRepository][addBookingToUser] - addBookingToUser.");
      //TODO outsource the .set method
      await FirebaseFirestore.instance.collection('users').doc(user.uid)
          .update({ 'bookings': FieldValue.arrayUnion([bookingId])});
    }on FirebaseAuthException catch(e){
      developer.log("[user_repository.dart][UsersRepository][addUser] - addBookingToUser Exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<void> changeUserName(User user, String newName)async{
    try {
      developer.log("[user_repository.dart][UsersRepository][addUser] - User added.");
      //TODO outsource the .set method
      await FirebaseFirestore.instance.collection('users').doc(user.uid)
          .update({ 'firstName': newName});
    }on FirebaseAuthException catch(e){
      developer.log("[user_repository.dart][UsersRepository][addUser] - User add Exception.");
      throw CustomException(message: e.message);
    }
  }

}
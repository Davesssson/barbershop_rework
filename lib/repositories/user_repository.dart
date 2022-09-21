import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;


abstract class BaseUsersRepository {
  Future<void> addUser(UserCredential result);
}

final userRepositoryProvider = Provider<UsersRepository>((ref) => UsersRepository(ref.read));

class UsersRepository implements BaseUsersRepository{
  final Reader _reader;

  const UsersRepository(this._reader);

  @override
  Future<void> addUser(UserCredential result)async{
    try {
      developer.log("[user_repository.dart][UsersRepository][addUser] - User added.");
      User user = result.user!;
      //TODO outsource the .set method
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          { 'firstName': 'Placeholder'});
    }on FirebaseAuthException catch(e){
      developer.log("[user_repository.dart][UsersRepository][addUser] - User add Exception.");
      throw CustomException(message: e.message);
    }
  }

}
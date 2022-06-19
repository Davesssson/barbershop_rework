import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_shopping_list/general_providers.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


abstract class BaseUsersRepository {

}

final usersRepositoryProvider = Provider<UsersRepository>((ref) => UsersRepository(ref.read));

class UsersRepository implements BaseUsersRepository{
  final Reader _reader;

  const UsersRepository(this._reader);

  Future<void> addUser(UserCredential result)async{
    User user = result.user!;
    await FirebaseFirestore.instance.collection('users')
        .doc(user.uid).set({ 'firstName': 'Placeholder'});
    //TODO outsource the .set method
  }

}
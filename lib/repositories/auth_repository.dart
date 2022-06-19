import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_shopping_list/general_providers.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:flutter_shopping_list/repositories/users_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  Future<void> signInAnonymously();
  User? getCurrentUser();
  Future<void> signOut();
  Future<void> singInViaEmailAndPassword(String email, String password);
}

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref.read));

class AuthRepository implements BaseAuthRepository {
  final Reader _read;

  const AuthRepository(this._read);

  @override
  Stream<User?> get authStateChanges =>
      _read(firebaseAuthProvider).authStateChanges();

  @override
  Future<void> signInAnonymously() async {
    try {
      await _read(firebaseAuthProvider).signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  User? getCurrentUser() {
    try {
      return _read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _read(firebaseAuthProvider).signOut();
     // await signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> singInViaEmailAndPassword(String email, String password) async {
    try {
      await _read(firebaseAuthProvider).signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {  //todo add different error handling (existing, in use, weak password, etc)
    try { //TODO get in parameters the user data from the reg process
      UserCredential result = await _read(firebaseAuthProvider).createUserWithEmailAndPassword(email: email, password: password);
      _read(usersRepositoryProvider).addUser(result);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}

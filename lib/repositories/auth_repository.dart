import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_shopping_list/general_providers.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:flutter_shopping_list/repositories/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;

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
      developer.log("[auth_repository.dart][AuthRepository][signInAnonymously] - Signed in anonymously.");
      await _read(firebaseAuthProvider).signInAnonymously();
    } on FirebaseAuthException catch (e) {
      developer.log("[auth_repository.dart][AuthRepository][signInAnonymously] - Sign in anonymously Exception.");
      throw CustomException(message: e.message);
    }
  }

  @override
  User? getCurrentUser() {
    try {
      developer.log("[auth_repository.dart][AuthRepository][getCurrentUser] - Get current user.");
      return _read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (e) {
      developer.log("[auth_repository.dart][AuthRepository][getCurrentUser] - Get current user Exception.");
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      developer.log("[auth_repository.dart][AuthRepository][signOut] - Sign out.");
      await _read(firebaseAuthProvider).signOut();
     // await signInAnonymously();
    } on FirebaseAuthException catch (e) {
      developer.log("[auth_repository.dart][AuthRepository][signOut] - Sign out Exception.");
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> singInViaEmailAndPassword(String email, String password) async {
    try {
      developer.log("[auth_repository.dart][AuthRepository][singInViaEmailAndPassword] - Sign in via Email.");
      await _read(firebaseAuthProvider).signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      developer.log("[auth_repository.dart][AuthRepository][singInViaEmailAndPassword] - Sign in via Email Exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<UserCredential?> createUserWithEmailAndPassword(String email, String password) async {  //todo add different error handling (existing, in use, weak password, etc)
    try { //TODO get in parameters the user data from the reg process
      developer.log("[auth_repository.dart][AuthRepository][createUserWithEmailAndPassword] - Register  via Email.");
      UserCredential result = await _read(firebaseAuthProvider).createUserWithEmailAndPassword(email: email, password: password);
      print("user creation"+result.toString());
      _read(userRepositoryProvider).addUser(result);
      return result;
    } on FirebaseAuthException catch (e) {
      developer.log("[auth_repository.dart][AuthRepository][createUserWithEmailAndPassword] - Register  via Email Exception.");
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateUsername(User? user, String newName) async {
    try {
      developer.log("[auth_repository.dart][AuthRepository][singInViaEmailAndPassword] - Sign in via Email.");
      if (user == null) return;
      await user.updateDisplayName(newName);
      _read(userRepositoryProvider).changeUserName(user,newName);
    } on FirebaseAuthException catch (e) {
      developer.log("[auth_repository.dart][AuthRepository][singInViaEmailAndPassword] - Sign in via Email Exception.");
      throw CustomException(message: e.message);
    }
  }
  Future<String> getUsernameFromId(String id)async{
    try{
      final snap = await _read(firebaseFirestoreProvider).collection("users").doc(id).get();
      return snap['firstName'];
    }on FirebaseAuthException catch(e){
      throw CustomException(message: e.message);
    }
  }
}

import 'dart:async';
import 'dart:developer' as developer;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_shopping_list/repositories/auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authControllerProvider = StateNotifierProvider<AuthController, User?>(
  (ref) => AuthController(ref.read)/*..appStarted()*/,
);

class AuthController extends StateNotifier<User?> {
  final Reader _read;

  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._read) : super(null) {
    developer.log("[auth_controller.dart][AuthController][AuthControllerConstructor] - AuthController Constructed.");
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _read(authRepositoryProvider)
        .authStateChanges
        .listen((user) => state = user);
  }

  @override
  void dispose() {
    developer.log("[auth_controller.dart][AuthController][dispose] - AuthController disposed.");
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

 // void appStarted() async {
 //   final user = _read(authRepositoryProvider).getCurrentUser();
 //   if (user == null) {
 //     await _read(authRepositoryProvider).signInAnonymously();
 //   }
 // }

  void signInAnonymously() async{
    developer.log("[auth_controller.dart][AuthRepository][signInAnonymously] - Signed in anonymously.");
    await _read(authRepositoryProvider).signInAnonymously();
  }

  void signOut() async {
    developer.log("[auth_controller.dart][AuthRepository][signOut] - signOut.");
    await _read(authRepositoryProvider).signOut();
  }

  void singInViaEmailAndPassword(String email, String password) async{
    developer.log("[auth_controller.dart][AuthRepository][singInViaEmailAndPassword] - Sign in Email.");
    await _read(authRepositoryProvider).singInViaEmailAndPassword(email,password);
  }

  void createUserWithEmailAndPassword(String email, String password) async{
    developer.log("[auth_controller.dart][AuthRepository][createUserWithEmailAndPassword] - Create user with Email.");
    await _read(authRepositoryProvider).createUserWithEmailAndPassword(email,password);
  }

}

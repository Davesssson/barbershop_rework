// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/auth_controller.dart';
import 'package:flutter_shopping_list/firebase_options.dart';
import 'package:flutter_shopping_list/repositories/auth_repository.dart';
import 'package:flutter_shopping_list/ui/home_screen.dart';
import 'package:flutter_shopping_list/ui/list_screen/list_screen.dart';
import 'package:flutter_shopping_list/ui/list_screen/variants/mobile/list_screen_mobile_final.dart';
import 'package:flutter_shopping_list/ui/list_screen/variants/mobile/widgets/horizontalList.dart';
import 'package:flutter_shopping_list/ui/widgets/bottom_nav_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_shopping_list/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'mockFirebase.dart';

class FakeAutRepository implements AuthRepository {
  MockFirebaseAuth auth = MockFirebaseAuth();

  @override
  // TODO: implement authStateChanges
  Stream<User?> get authStateChanges {return auth.authStateChanges(); }


  @override
  Future<UserCredential?> createUserWithEmailAndPassword(String email, String password, {String role = "customer"}) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  User? getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> getUsernameFromId(String id) {
    // TODO: implement getUsernameFromId
    throw UnimplementedError();
  }

  @override
  Future<void> signInAnonymously() {
    // TODO: implement signInAnonymously
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> singInViaEmailAndPassword(String email, String password) {
    // TODO: implement singInViaEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> updateUsername(User? user, String newName) {
    // TODO: implement updateUsername
    throw UnimplementedError();
  }
}



void main() {
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  Widget createWidgetForTesting({required Widget child}){
    return MaterialApp(
      home: child,
    );
  }


  testWidgets('BottomNavBar', (WidgetTester tester) async {
    await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(FakeAutRepository())
          ],
          //child: createWidgetForTesting(child: BottomNavBar())
          child:MaterialApp(
            home:Scaffold(
              body: BottomNavBar(),
            )
          )
        )
    );
    /*final Finder fab = find.byElementType(BottomNavBar);*/
    expect(find.byType(BottomNavBar),findsNWidgets(1));
  });

  testWidgets('list_screen_mobile_final', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
        ProviderScope(
            overrides: [
              //authRepositoryProvider.overrideWithValue(FakeAutRepository())
            ],
            //child: createWidgetForTesting(child: BottomNavBar())
            child:MaterialApp(
                home: ListScreen_mobile_final()

            )
        )
    );
  expect(find.byType(HorizontalList),findsNWidgets(1));
  });
}

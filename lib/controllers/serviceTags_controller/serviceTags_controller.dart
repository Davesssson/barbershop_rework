
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import '../../general_providers.dart';
import '../../repositories/custom_exception.dart';

class ServiceTagsListStateController extends StateNotifier<AsyncValue<List<String>>>{
  final Reader _read;
  ServiceTagsListStateController(this._read):super(AsyncValue.loading()){
    retrieveServiceTags();
  }

  Future<void> retrieveServiceTags()async {
    developer.log("[service_repository.dart][ServiceRepository][retrieveServiceTags] - Retrieving serviceTags. . .");
    try {
      final snap = await _read(firebaseFirestoreProvider).collection('serviceTags').get();
      snap.docs.forEach((doc) {
        print(doc.id.toString());
      });
      final serviceTags =  snap.docs.map((doc) => doc.id.toString()).toList();;
      if (mounted) {
        state = AsyncValue.data(serviceTags);
      }
    } on FirebaseException catch (e) {
      developer.log("Failure during retrieving serviceTags");
      throw CustomException(message: e.message);
    }
  }
  Future<void> addServiceTag({required String newTag})async {
    developer.log("[service_repository.dart][ServiceRepository][retrieveServiceTags] - Retrieving serviceTags. . .");
    try {
      await _read(firebaseFirestoreProvider)
          .collection('serviceTags')
          .doc(newTag)
          .set({});

      state.whenData((items) =>
      state = AsyncValue.data(items..add(newTag)));
    } on FirebaseException catch (e) {
      developer.log("Failure during retrieving serviceTags");
      throw CustomException(message: e.message);
    }
  }

}
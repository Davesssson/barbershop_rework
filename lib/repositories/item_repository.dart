import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shopping_list/extensions/firebase_firestore_extension.dart';
import 'package:flutter_shopping_list/general_providers.dart';
import 'package:flutter_shopping_list/models/item/item_model.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;

abstract class BaseItemRepository {
  Future<List<Item>> retrieveItems({required String userId});
  Future<String> createItem({required String userId, required Item item});
  Future<void> updateItem({required String userId, required Item item});
  Future<void> deleteItem({required String userId, required String itemId});
}

final itemRepositoryProvider = Provider<ItemRepository>((ref) => ItemRepository(ref.read));

class ItemRepository implements BaseItemRepository {
  final Reader _read;

  const ItemRepository(this._read);

  @override
  Future<List<Item>> retrieveItems({required String userId}) async {
    developer.log("[itemrepository.dart][itemRepository][retrieveItems] - Items retrieved.");
    try {
      final snap =
          await _read(firebaseFirestoreProvider).usersListRef(userId).get();
      return snap.docs.map((doc) => Item.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("[itemrepository.dart][itemRepository][retrieveItems] - Item retrieve exception.");
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> createItem({
    required String userId,
    required Item item,
  }) async {
    developer.log("[itemrepository.dart][itemRepository][createItem] - Item created.");
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .usersListRef(userId)
          .add(item.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      developer.log("[itemrepository.dart][itemRepository][createItem] - Item create exception.");
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateItem({required String userId, required Item item}) async {
    developer.log("[itemrepository.dart][itemRepository][updateItem] - Item updated.");
    try {
      await _read(firebaseFirestoreProvider)
          .usersListRef(userId)
          .doc(item.id)
          .update(item.toDocument());
    } on FirebaseException catch (e) {
      developer.log("[itemrepository.dart][itemRepository][updateItem] - Update item exception.");
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteItem({
    required String userId,
    required String itemId,
  }) async {
    developer.log("[itemrepository.dart][itemRepository][deleteItem] - Item deleted");
    try {
      await _read(firebaseFirestoreProvider)
          .usersListRef(userId)
          .doc(itemId)
          .delete();
    } on FirebaseException catch (e) {
      developer.log("[itemrepository.dart][itemRepository][deleteItem] - Delete item exception");
      throw CustomException(message: e.message);
    }
  }
}

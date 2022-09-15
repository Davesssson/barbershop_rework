import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';



class MyDatabase {
  Future<List<Barbershop>> fetchItems(Barbershop? item) async {
    final itemsCollectionRef = FirebaseFirestore.instance.collection('barbershops');

    if (item == null) {
      final documentSnapshot = await itemsCollectionRef
          .limit(1000)
          .get();
      return documentSnapshot.docs
          .map<Barbershop>(
            (data) => Barbershop.fromDocument(data)).toList();
    } else {
      final documentSnapshot = await itemsCollectionRef
          .startAfter([item.id])
          .limit(1000)
          .get();

      return documentSnapshot.docs
          .map<Barbershop>(
            (data) => Barbershop
                .fromDocument(data))
          .toList();
    }
  }
}

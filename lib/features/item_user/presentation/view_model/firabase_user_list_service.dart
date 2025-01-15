import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../add_item/presentation/view_model/item_model.dart';

class FirebaseServiceItemsUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> deleteItem(String itemId) async {
    try {
      await _firestore.collection('items').doc(itemId).delete();
    } catch (e) {
      throw Exception('حدث خطأ أثناء حذف العنصر: $e');
    }
  }

  Future<List<Item>> fetchCategoryItemsUser(String userId) async {
    final snapshot = await _firestore
        .collection('items')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => Item.fromMap(doc.data(), doc.id))
        .toList();
  }
}

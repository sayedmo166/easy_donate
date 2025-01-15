import 'package:cloud_firestore/cloud_firestore.dart';
import '../features/add_item/presentation/view_model/item_model.dart';

class FirebaseServiceItems {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Item>> fetchCategoryItems(String categoryType) async {
    final snapshot = await _firestore
        .collection('items')
        .where('itemType', isEqualTo: categoryType)
        .get();

    return snapshot.docs
        .map((doc) => Item.fromMap(doc.data(), doc.id))
        .toList();
  }
}

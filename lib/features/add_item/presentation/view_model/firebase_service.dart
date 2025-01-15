import 'package:cloud_firestore/cloud_firestore.dart';
import 'item_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadItemData(Item item) async {
    try {
      await _firestore.collection('items').add(item.toMap());
    } catch (e) {
      throw Exception("فشل في إرسال البيانات إلى Firebase");
    }
  }
}

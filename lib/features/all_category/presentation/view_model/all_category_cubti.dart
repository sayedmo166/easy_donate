import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../add_item/presentation/view_model/item_model.dart';
import 'all_category_state.dart';

class AllCategoryCubit extends Cubit<AllCategoryState> {
  AllCategoryCubit() : super(AllCategoryInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Item> items = [];

  void fetchItems() async {
    emit(AllCategoryLoading());
    try {
      QuerySnapshot snapshot = await _firestore.collection('items').get();

      if (snapshot.docs.isEmpty) {
        emit(AllCategoryLoaded([]));
      } else {
        items = snapshot.docs
            .map((doc) => Item.fromMap(doc.data() as Map<String, dynamic>, doc.id))
            .toList();
        emit(AllCategoryLoaded(items));
      }
    } catch (e) {
      emit(AllCategoryError(e.toString()));
    }
  }
}

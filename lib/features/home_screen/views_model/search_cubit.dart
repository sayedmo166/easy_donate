
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dounts_store/features/home_screen/views_model/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> performSearch(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('items')
          .where('address', isGreaterThanOrEqualTo: query)
          .where('userName', isLessThanOrEqualTo: "$query\uf8ff")
          .get();

      final results = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      emit(SearchLoaded(results));
    } catch (e) {
      emit(SearchError("حدث خطأ أثناء البحث: $e"));
    }
  }
}

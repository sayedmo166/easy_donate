import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/firabase_service_items.dart';
import 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  final FirebaseServiceItems firebaseServiceItems;


  BooksCubit(this.firebaseServiceItems) : super(BooksInitial());

  Future<void> fetchBooksItems() async {
    emit(BooksLoading());

    try {
      final items = await firebaseServiceItems.fetchCategoryItems('كتب دراسية');
      emit(BooksLoaded(items));
    } catch (e) {
      emit(BooksError('حدث خطأ أثناء تحميل البيانات: $e'));
    }
  }
}

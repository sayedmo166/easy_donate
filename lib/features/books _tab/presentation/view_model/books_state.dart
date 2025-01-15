
import '../../../add_item/presentation/view_model/item_model.dart';


abstract class BooksState {}
class BooksInitial extends BooksState {}

class   BooksLoading extends BooksState {}

class   BooksLoaded extends BooksState {
  final List<Item> items;

  BooksLoaded(this.items);
}

class   BooksError extends BooksState {
  final String error;

  BooksError(this.error);
}


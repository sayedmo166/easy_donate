
import '../../../add_item/presentation/view_model/item_model.dart';


abstract class AllCategoryState {}
class  AllCategoryInitial extends AllCategoryState {}

class  AllCategoryLoading extends AllCategoryState {}

class  AllCategoryLoaded extends AllCategoryState {
  final List<Item> items;

  AllCategoryLoaded(this.items);
}

class  AllCategoryError extends AllCategoryState {
  final String error;

  AllCategoryError(this.error);
}


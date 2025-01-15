
import '../../../add_item/presentation/view_model/item_model.dart';


abstract class ClothesState {}
class  ClothesInitial extends ClothesState {}

class   ClothesLoading extends ClothesState {}

class   ClothesLoaded extends ClothesState {
  final List<Item> items;

  ClothesLoaded(this.items);
}

class   ClothesError extends ClothesState {
  final String error;

  ClothesError(this.error);
}


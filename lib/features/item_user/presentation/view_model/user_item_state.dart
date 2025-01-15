import '../../../add_item/presentation/view_model/item_model.dart';

abstract class UserItemsState {}

class UserItemsInitial extends UserItemsState {}

class UserItemsLoading extends UserItemsState {}

class UserItemsLoaded extends UserItemsState {
  final List<Item> items;

  UserItemsLoaded(this.items);
}

class UserItemsEmpty extends UserItemsState {}

class UserItemsError extends UserItemsState {
  final String error;

  UserItemsError(this.error);
}

class UserItemsDeleted extends UserItemsState {
  final String itemId;

  UserItemsDeleted(this.itemId);
}

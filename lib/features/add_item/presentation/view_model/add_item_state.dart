import 'dart:io';

abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemUploading extends ItemState {}

class ItemUploaded extends ItemState {}

class ItemError extends ItemState {
  final String message;
  ItemError(this.message);
}
class ItemImageSelected extends ItemState {
  final File image;
  ItemImageSelected(this.image);
}

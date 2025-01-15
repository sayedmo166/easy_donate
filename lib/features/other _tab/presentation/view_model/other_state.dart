import 'package:meta/meta.dart';

import '../../../add_item/presentation/view_model/item_model.dart';

abstract class OtherState {}

class OtherInitial extends OtherState {}

class OtherLoading extends OtherState {}

class OtherLoaded extends OtherState {
  final List<Item> items;

  OtherLoaded(this.items);
}

class OtherError extends OtherState {
  final String error;

  OtherError(this.error);
}

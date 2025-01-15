import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dounts_store/features/item_user/presentation/view_model/user_item_state.dart';
import 'firabase_user_list_service.dart';

class UserItemsCubit extends Cubit<UserItemsState> {
  final FirebaseServiceItemsUser firebaseServiceItemsUser;

  UserItemsCubit(this.firebaseServiceItemsUser) : super(UserItemsInitial());

  Future<void> fetchUserItems(String userId) async {
    emit(UserItemsLoading());
    try {
      final items = await firebaseServiceItemsUser.fetchCategoryItemsUser(userId);
      if (items.isEmpty) {
        emit(UserItemsEmpty());
      } else {
        emit(UserItemsLoaded(items));
      }
    } catch (e) {
      emit(UserItemsError('حدث خطأ أثناء تحميل البيانات: $e'));
    }
  }

  Future<void> deleteItem(String itemId, String userId) async {
    try {
      await firebaseServiceItemsUser.deleteItem(itemId);
      fetchUserItems(userId);
      emit(UserItemsDeleted(itemId));
    } catch (e) {
      emit(UserItemsError('حدث خطأ أثناء الحذف: $e'));
    }
  }
}

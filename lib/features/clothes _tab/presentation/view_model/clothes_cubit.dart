import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/firabase_service_items.dart';
import 'clothes_state.dart';

class ClothesCubit extends Cubit<ClothesState> {
  final FirebaseServiceItems firebaseServiceItems;

  ClothesCubit(this.firebaseServiceItems) : super(ClothesInitial());


  Future<void> fetchClothesItems() async {
    emit(ClothesLoading());

    try {
      final items = await firebaseServiceItems.fetchCategoryItems('ملابس');
      emit(ClothesLoaded(items));
    } catch (e) {
      emit(ClothesError('حدث خطأ أثناء تحميل البيانات: $e'));
    }
  }
}

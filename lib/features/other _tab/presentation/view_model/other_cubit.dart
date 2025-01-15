import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/firabase_service_items.dart';
import 'other_state.dart';

class OtherCubit extends Cubit<OtherState> {
  final FirebaseServiceItems firebaseServiceItems;

  OtherCubit(this.firebaseServiceItems) : super(OtherInitial());

  Future<void> fetchOtherItems() async {
    emit(OtherLoading());

    try {
      final items = await firebaseServiceItems.fetchCategoryItems('اخري');
      emit(OtherLoaded(items));
    } catch (e) {
      emit(OtherError('حدث خطأ أثناء تحميل البيانات: $e'));
    }
  }
}

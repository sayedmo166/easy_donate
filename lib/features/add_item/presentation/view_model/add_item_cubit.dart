  import 'dart:io';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'add_item_state.dart';
  import 'cloudinary_service.dart';
  import 'firebase_service.dart';
  import 'item_model.dart';

  class ItemCubit extends Cubit<ItemState> {
    final CloudinaryService cloudinaryService;
    final FirebaseService firebaseService;

    ItemCubit(this.cloudinaryService, this.firebaseService) : super(ItemInitial());

    File? selectedImage;

    void selectImage(File image) {
      selectedImage = image;
      emit(ItemImageSelected(image));
    }

    Future<void> uploadItem({
      required String address,
      required String phone,
      required String itemType,
      required String userId,
      required String userName,
    }) async {
      if (selectedImage == null) {
        emit(ItemError('يجب اختيار صورة.'));
        return;
      }

      emit(ItemUploading());

      try {
        final imageUrl = await cloudinaryService.uploadImage(selectedImage!);


        final item = Item(
          address: address,
          phone: phone,
          itemType: itemType,
          imageUrl: imageUrl,
          userId: userId,
          userName: userName,
          createdAt: DateTime.now(),
          id: '',
        );


        await firebaseService.uploadItemData(item);
        emit(ItemUploaded());
      } catch (e) {
        emit(ItemError(e.toString()));
      }
    }

  }

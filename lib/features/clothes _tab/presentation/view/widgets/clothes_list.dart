import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../add_item/presentation/view_model/item_model.dart';
import '../../view_model/clothes_cubit.dart';
import '../../view_model/clothes_state.dart';
import 'clothes_list_build.dart';

class ClothesList extends StatefulWidget {
  const ClothesList({super.key});

  @override
  State<ClothesList> createState() => _ListItemState();
}

class _ListItemState extends State<ClothesList> {
  @override
  void initState() {
    super.initState();
    context.read<ClothesCubit>().fetchClothesItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClothesCubit, ClothesState>(
      builder: (context, state) {
        if (state is ClothesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ClothesError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is ClothesLoaded) {
          List<Item> items = state.items;

          if (items.isEmpty) {
            return Center(
              child: Text(
                'لا يوجد ملابس للأسف',
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.2,
                  ),
                ),
              ),
            );
          }

          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return ClothesListBuild(
                  imageUrl: item.imageUrl,
                  location: item.address,
                  category: item.itemType,
                  phone: item.phone,
                  userName: item.userName,
                  createdAt: item.createdAt,
                  index: index,
                );
              },
            ),
          );
        }

        return Center(
          child: Text(
            'فارغ',
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 45,
                height: 1.2,
              ),
            ),
          ),
        );
      },
    );
  }
}

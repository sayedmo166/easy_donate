import 'package:dounts_store/features/all_category/presentation/view_model/all_category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../add_item/presentation/view_model/item_model.dart';
import '../../view_model/all_category_cubti.dart';
import 'list_item_build.dart';

class ListItem extends StatefulWidget {
  const ListItem({super.key});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  void initState() {
    super.initState();
    context.read<AllCategoryCubit>().fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCategoryCubit, AllCategoryState>(
      builder: (context, state) {
        if (state is AllCategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AllCategoryError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is AllCategoryLoaded) {
          List<Item> items = state.items;

          if (items.isEmpty) {
            return Center(
              child: Text(
                'لا يوجد تبرعات للأسف',
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
                return ListItemBuild(
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



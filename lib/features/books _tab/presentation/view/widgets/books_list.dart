import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../add_item/presentation/view_model/item_model.dart';
import '../../view_model/books_cubit.dart';
import '../../view_model/books_state.dart';
import 'books_list_build.dart';

class BooksList extends StatefulWidget {
  const BooksList({super.key});

  @override
  State<BooksList> createState() => _ListItemState();
}

class _ListItemState extends State<BooksList> {
  @override
  void initState() {
    super.initState();

    context.read<BooksCubit>().fetchBooksItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is BooksLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BooksError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is BooksLoaded) {
          List<Item> items = state.items;

          if (items.isEmpty) {
            return Center(
              child: Text(
                'لا يوجد كتب للأسف',
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
                return BooksListBuild(
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

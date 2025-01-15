import 'package:dounts_store/features/books%20_tab/presentation/view/widgets/books_list.dart';
import 'package:dounts_store/features/clothes%20_tab/presentation/view/widgets/clothes_list.dart';
import 'package:flutter/material.dart';

class BooksTabBody extends StatelessWidget {
  const BooksTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Expanded(child: BooksList())],
    );
  }
}

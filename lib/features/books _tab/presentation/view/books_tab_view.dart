import 'package:dounts_store/features/books%20_tab/presentation/view/widgets/books_tab_body.dart';
import 'package:flutter/material.dart';

class BooksTabView extends StatelessWidget {
  const BooksTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: BooksTabBody(),
    );
  }
}

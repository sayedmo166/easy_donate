import 'package:dounts_store/features/clothes%20_tab/presentation/view/clothes_tab_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../all_category/presentation/view/all_category_view.dart';
import '../../../books _tab/presentation/view/books_tab_view.dart';
import '../../../other _tab/presentation/view/other_tab_view.dart';

class TabsBar extends StatelessWidget {
  const TabsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            labelColor: Color(0xff66c1b0),
            unselectedLabelColor: Color(0xff66c1b0),
            indicatorColor: Color(0xff66c1b0),
            labelStyle: TextStyle(fontSize: 12),
            tabs: [
              Tab(
                icon: Icon(Icons.home, color: Color(0xff66c1b0)),
                text: 'الرئيسية',
              ),
              Tab(
                icon: Icon(Icons.shopping_bag, color: Color(0xff66c1b0)),
                text: 'ملابس',
              ),
              Tab(
                icon: Icon(Icons.book_sharp, color: Color(0xff66c1b0)),
                text: 'كتب دراسية',
              ),
              Tab(
                icon: Icon(Icons.more_horiz, color: Color(0xff66c1b0)),
                text: 'أخرى',
              ),
            ],
          ),


          Expanded(
            child: TabBarView(
              children: [
                AllCategoryView(),
                ClothesTabView(),
                BooksTabView(),
                OtherTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

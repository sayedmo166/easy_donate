import 'package:flutter/material.dart';

import 'list_item.dart';

class AllCategoryViewBody extends StatelessWidget {
  const AllCategoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Expanded(child: ListItem())],
    );
  }
}

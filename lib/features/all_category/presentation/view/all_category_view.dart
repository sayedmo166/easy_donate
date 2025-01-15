import 'package:dounts_store/features/all_category/presentation/view/widgets/all_category_view_body.dart';
import 'package:flutter/material.dart';

class AllCategoryView extends StatelessWidget {
  const AllCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: AllCategoryViewBody(),
    );
  }
}

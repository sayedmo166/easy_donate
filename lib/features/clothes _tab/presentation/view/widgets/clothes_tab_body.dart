import 'package:dounts_store/features/clothes%20_tab/presentation/view/widgets/clothes_list.dart';
import 'package:flutter/material.dart';

class ClothesTabBody extends StatelessWidget {
  const ClothesTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Expanded(child: ClothesList())],
    );
  }
}

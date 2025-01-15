import 'package:dounts_store/features/clothes%20_tab/presentation/view/widgets/clothes_tab_body.dart';
import 'package:flutter/material.dart';

class ClothesTabView extends StatelessWidget {
  const ClothesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: ClothesTabBody(),
    );
  }
}

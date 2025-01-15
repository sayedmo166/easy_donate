import 'package:dounts_store/features/other%20_tab/presentation/view/widgets/other_tab_body.dart';
import 'package:flutter/material.dart';

class OtherTabView extends StatelessWidget {
  const OtherTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: OtherTabBody(),
    );
  }
}

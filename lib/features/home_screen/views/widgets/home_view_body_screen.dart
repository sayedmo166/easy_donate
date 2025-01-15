import 'package:dounts_store/features/home_screen/views/widgets/tabs_bar.dart';
import 'package:flutter/material.dart';
import 'customAppBarScreen.dart';

class HomeViewBodyScreen extends StatelessWidget {
  const HomeViewBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBarScreen(),
        SizedBox(height: 15),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TabsBar(),

          ),
        ),
      ],
    );
  }
}
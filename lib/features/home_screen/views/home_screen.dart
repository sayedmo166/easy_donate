import 'package:dounts_store/features/home_screen/views/widgets/home_view_body_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold( backgroundColor: Colors.white,
        body: HomeViewBodyScreen(),

      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../features/about_us/presentation/view/about_us_view.dart';
import '../../features/add_item/presentation/view/add_item_view.dart';
import '../../features/home_screen/views/home_screen.dart';
import '../../features/item_user/presentation/view/user_item_screen.dart';
import 'navigation_cubit.dart';

class NavigationView extends StatelessWidget {
  final String? userId;

  const NavigationView({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const AddItemView(),
      const UserItemScreen(),
    ];

    final screenHeight = MediaQuery.of(context).size.height;
    final bottomNavBarHeight = screenHeight * 0.08;

    return Scaffold(
      body: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return screens[currentIndex];
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return CurvedNavigationBar(
            backgroundColor: const Color(0xfff2f2f2),
            items: const [
              Icon(Icons.home, size: 30, color: Colors.white),
              Icon(Icons.add_box_rounded, size: 30, color: Colors.white),
              Icon(Icons.list_alt, size: 30, color: Colors.white),
            ],
            index: currentIndex,
            onTap: (index) {
              context.read<NavigationCubit>().updateIndex(index);
            },
            color: const Color(0xff66c1b0),
            buttonBackgroundColor: const Color(0xff66c1b0),
            animationDuration: const Duration(milliseconds: 300),
            height: bottomNavBarHeight,
          );
        },
      ),
    );
  }
}

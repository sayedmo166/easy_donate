import 'package:dounts_store/features/item_user/presentation/view/widgets/user_item_body.dart';
import 'package:flutter/material.dart';

class UserItemScreen extends StatelessWidget {
  const UserItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( centerTitle: true,
        title: const Text("قائمه التبرعات الخاصه بك"),
        backgroundColor: const Color(0xff66c1b0),
        titleTextStyle: const TextStyle(color: Colors.white,fontSize: 25),
      ),

      backgroundColor: Colors.white,
      body: const UserItemBody(),
    );
  }
}

import 'package:dounts_store/features/clothes%20_tab/presentation/view/widgets/clothes_list.dart';
import 'package:dounts_store/features/item_user/presentation/view/widgets/user_item_list.dart';
import 'package:flutter/material.dart';

class UserItemBody extends StatelessWidget {
  const UserItemBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Expanded(child:UserItemsList())],
    );
  }
}

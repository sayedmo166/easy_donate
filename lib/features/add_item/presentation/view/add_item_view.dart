import 'package:dounts_store/features/add_item/presentation/view/widegts/add_item_view_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddItemView extends StatelessWidget {
  const  AddItemView ({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: AddItemViewBody(),
      ),
    );
  }
}

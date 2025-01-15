import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../add_item/presentation/view_model/item_model.dart';
import '../../view_model/other_cubit.dart';
import '../../view_model/other_state.dart';
import 'other_list_build.dart';

class OtherList extends StatefulWidget {
  const OtherList({super.key});

  @override
  State<OtherList> createState() => _OtherListState();
}

class _OtherListState extends State<OtherList> {
  @override
  void initState() {
    super.initState();
    context.read<OtherCubit>().fetchOtherItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherCubit, OtherState>(
      builder: (context, state) {
        if (state is OtherLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OtherError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is OtherLoaded) {
          List<Item> items = state.items;

          if (items.isEmpty) {
            return Center(
              child: Text(
                'لا توجد عناصر أخرى للأسف',
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.2,
                  ),
                ),
              ),
            );
          }

          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return OtherListBuild(
                  imageUrl: item.imageUrl,
                  location: item.address,
                  category: item.itemType,
                  phone: item.phone,
                  userName: item.userName,
                  createdAt: item.createdAt,
                  index: index,
                );
              },
            ),
          );
        }

        return Center(
          child: Text(
            'فارغ',
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 45,
                height: 1.2,
              ),
            ),
          ),
        );
      },
    );
  }
}

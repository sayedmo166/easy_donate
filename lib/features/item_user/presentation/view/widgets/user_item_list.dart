import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../add_item/presentation/view_model/item_model.dart';
import '../../view_model/user_item_cubit.dart';
import '../../view_model/user_item_state.dart';
import 'user_item_list_build.dart';

class UserItemsList extends StatefulWidget {
  const UserItemsList({super.key});

  @override
  State<UserItemsList> createState() => _UserItemsListState();
}

class _UserItemsListState extends State<UserItemsList> {
  Map<String, bool> selectedItems = {};

  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      context.read<UserItemsCubit>().fetchUserItems(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserItemsCubit, UserItemsState>(
      builder: (context, state) {
        if (state is UserItemsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserItemsError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is UserItemsLoaded) {
          List<Item> items = state.items;

          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                bool isChecked = selectedItems[item.id] ?? false;

                return ListTile(
                  leading: Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) async {
                      setState(() {
                        selectedItems[item.id] = value!;
                      });

                      if (value!) {
                        final userId = FirebaseAuth.instance.currentUser?.uid;
                        if (userId != null) {
                          await context.read<UserItemsCubit>().deleteItem(item.id, userId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم التبرع ب العنصر')),
                          );
                        }
                      }
                    },
                  ),
                  title: UserItemListBuild(
                    imageUrl: item.imageUrl,
                    location: item.address,
                    category: item.itemType,
                    phone: item.phone,
                    userName: item.userName,
                    createdAt: item.createdAt,
                    index: index,
                  ),
                );
              },
            ),
          );
        } else if (state is UserItemsEmpty) {
          return Center(
            child: Text(
              'لا يوجد عناصر مضافة بعد',
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

        return Center(child: Text('فارغ'));
      },
    );
  }
}


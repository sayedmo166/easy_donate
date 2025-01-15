import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../all_category/presentation/view/widgets/list_item_build.dart';
import '../../views_model/search_cubit.dart';
import '../../views_model/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("البحث"),
        backgroundColor: const Color(0xff66c1b0),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: Column(
          children: [

            Container(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                onChanged: (query) {

                  context.read<SearchCubit>().performSearch(query);
                },
                decoration: const InputDecoration(
                  hintText: 'ابحث هنا...',
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  suffixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),


            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchError) {
                    return Center(child: Text('حدث خطأ أثناء البحث: ${state.message}'));
                  } else if (state is SearchLoaded) {
                    final results = state.results;

                    if (results.isEmpty) {
                      return const Center(child: Text('لا توجد نتائج.'));
                    }

                    return ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final item = results[index];
                        return ListItemBuild(
                          imageUrl: item['imageUrl'] ?? '',
                          location: item['address'] ?? '',
                          category: item['itemType'] ?? '',
                          phone: item['phone'] ?? '',
                          userName: item['userName'] ?? '',
                          createdAt: DateTime.parse(item['createdAt'] ?? '2023-01-01T00:00:00'),
                          index: index,
                        );
                      },
                    );
                  }

                  return const Center(child: Text('أدخل نصًا للبحث'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

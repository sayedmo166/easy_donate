import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app_router.dart';
import 'core/firabase_service_items.dart';
import 'core/navigation_bar/navigation_cubit.dart';
import 'features/add_item/presentation/view_model/add_item_cubit.dart';
import 'features/add_item/presentation/view_model/cloudinary_service.dart';
import 'features/add_item/presentation/view_model/firebase_service.dart';
import 'features/all_category/presentation/view_model/all_category_cubti.dart';
import 'features/auth/presentation/views_model/auth__cubit.dart';
import 'features/books _tab/presentation/view_model/books_cubit.dart';
import 'features/clothes _tab/presentation/view_model/clothes_cubit.dart';
import 'features/home_screen/views_model/search_cubit.dart';
import 'features/item_user/presentation/view_model/firabase_user_list_service.dart';
import 'features/item_user/presentation/view_model/user_item_cubit.dart';
import 'features/other _tab/presentation/view_model/other_cubit.dart';
import 'core/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.containsKey('userId');
  final String? userId = prefs.getString('userId');

  runApp(MyApp(isLoggedIn: isLoggedIn, userId: userId));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? userId;

  const MyApp({super.key, required this.isLoggedIn, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => AuthCubit()..getCurrentUser()),
        BlocProvider<AllCategoryCubit>(
            create: (context) => AllCategoryCubit()..fetchItems()),
        BlocProvider<ClothesCubit>(
            create: (context) => ClothesCubit(FirebaseServiceItems())),
        BlocProvider<BooksCubit>(
            create: (context) => BooksCubit(FirebaseServiceItems())),
        BlocProvider<OtherCubit>(
            create: (context) => OtherCubit(FirebaseServiceItems())),
        BlocProvider<UserItemsCubit>(
            create: (context) => UserItemsCubit(FirebaseServiceItemsUser())),
        BlocProvider(
            create: (_) => ItemCubit(CloudinaryService(), FirebaseService())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: Approuter.router(isLoggedIn: isLoggedIn, userId: userId),
      ),
    );
  }
}

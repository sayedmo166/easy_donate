import 'package:go_router/go_router.dart';
import '../features/auth/presentation/views/Authentication/views/login_screen.dart';
import '../features/auth/presentation/views/Authentication/views/register_screen.dart';
import '../features/home_screen/views/home_screen.dart';
import '../features/home_screen/views/widgets/search_screen.dart';
import 'navigation_bar/navigation_view.dart';

abstract class Approuter {
  static GoRouter router({required bool isLoggedIn, required String? userId}) {
    return GoRouter(
      initialLocation: isLoggedIn ? '/NavigationView' : '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/SearchScreen',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: '/registerScreen',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/homeScreen',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/NavigationView',
          builder: (context, state) => NavigationView(userId: userId),
        ),
      ],
    );
  }
}

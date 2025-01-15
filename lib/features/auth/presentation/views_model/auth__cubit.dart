  import 'package:bloc/bloc.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'auth__state.dart';
  import 'firebase_service.dart';
  import 'uesr_model.dart';

  class AuthCubit extends Cubit<AuthState> {
    AuthCubit() : super(AuthInitial());

    UserModel? currentUser;

    Future<void> login({required String email, required String password}) async {
      emit(AuthLoading());
      try {
        currentUser = await FirebaseAuthService.login(email: email, password: password);

        final prefs = await SharedPreferences.getInstance();
        bool isSaved = await prefs.setString('userId', currentUser!.userId);

        if (isSaved) {
          emit(AuthSuccess(currentUser!));
        } else {
          emit(AuthError(message: 'Failed to save userId'));
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    }

    Future<void> logout() async {
      try {

        await FirebaseAuthService.logout();


        final prefs = await SharedPreferences.getInstance();
        bool isRemoved = await prefs.remove('userId');

        if (isRemoved) {

          emit(AuthLoggedOut());
        } else {

          emit(AuthError(message: 'Failed to remove userId from preferences'));
        }
      } catch (e) {

        emit(AuthError(message: 'Failed to log out: ${e.toString()}'));
      }
    }

    Future<void> register({
      required String name,
      required String email,
      required String password,
    }) async {
      emit(RegisterLoading());
      try {
        currentUser = await FirebaseAuthService.register(
          name: name,
          email: email,
          password: password,
        );

        final prefs = await SharedPreferences.getInstance();
        bool isSaved = await prefs.setString('userId', currentUser!.userId);

        if (isSaved) {
          emit(RegisterSuccess(currentUser!));
        } else {
          emit(RegisterError(message: 'Failed to save userId'));
        }
      } catch (e) {
        emit(RegisterError(message: e.toString()));
      }
    }

    Future<void> getCurrentUser() async {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (userId != null && userId.isNotEmpty) {
        try {
          currentUser = await FirebaseAuthService.getUserById(userId);
          emit(AuthSuccess(currentUser!));
        } catch (e) {
          emit(AuthError(message: 'User not found in Firestore'));
        }
      } 
    }
  }


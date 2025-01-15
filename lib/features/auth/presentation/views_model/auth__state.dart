import 'package:dounts_store/features/auth/presentation/views_model/uesr_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class AuthLoggedOut extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;
  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final UserModel user;
  RegisterSuccess(this.user);
}

class RegisterError extends AuthState {
  final String message;
  RegisterError({required this.message});
}

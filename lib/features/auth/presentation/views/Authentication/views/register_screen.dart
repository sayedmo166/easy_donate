import 'package:dounts_store/features/auth/presentation/views/Authentication/views/widgets/register_screen_view_body.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RegisterScreenViewBody(),
      ),
    );
  }
}

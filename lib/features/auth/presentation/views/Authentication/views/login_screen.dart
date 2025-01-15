import 'package:dounts_store/features/auth/presentation/views/Authentication/views/widgets/login_screen_view_body.dart';
import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor:  Colors.white,
        body: LoginScreenViewBody(),
      ),
    );
  }
}

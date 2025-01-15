import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../views_model/auth__cubit.dart';
import '../../../../views_model/auth__state.dart';
import 'custom_textFild.dart';

class LoginScreenViewBody extends StatelessWidget {
  LoginScreenViewBody({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return const Center(child: CircularProgressIndicator());
            },
          );
        } else if (state is AuthSuccess) {

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', state.user.userId);


          Navigator.of(context).pop();


          context.pushReplacement('/NavigationView');


          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Successful'), backgroundColor: Colors.green),
          );
        }
        else if (state is AuthLoggedOut) {

          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
          context.pushReplacement('/');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logged out successfully'), backgroundColor: Colors.green),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }



      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.1),
              Center(
                child: Image.asset(
                  'assets/images/72F03EE0-CFF5-4B46-A094-7D804AF927F0.jpeg.PNG',
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.2,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              FittedBox(
                child: Text(
                  'سجل الدخول ل حسابك',
                  style: GoogleFonts.manjari(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffFF6A7D),
                      fontSize: screenWidth * 0.08,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      taskController: emailController,
                      hint: 'البريد الاكتروني',
                      validate: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Email address mustn\'t be empty';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextField(
                      taskController: passwordController,
                      hint: 'كلمه السر',
                      icon: Icons.password,
                      ispassword: true,
                      validate: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Password mustn\'t be empty';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    SizedBox(
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          login(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFF6A7D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'ادخل',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.push('/registerScreen');
                          },
                          child: Text(
                            'سجل الان',
                            style: GoogleFonts.manjari(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffFF6A7D),
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "ليس لديك حساب ؟ ",
                          style: GoogleFonts.manjari(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      BlocProvider.of<AuthCubit>(context).login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
  }
}

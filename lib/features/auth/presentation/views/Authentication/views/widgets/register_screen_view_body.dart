import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../views_model/auth__cubit.dart';
import '../../../../views_model/auth__state.dart';
import 'custom_textFild.dart';

class RegisterScreenViewBody extends StatelessWidget {
  RegisterScreenViewBody({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is RegisterSuccess) {
          context.pushReplacement('/HomeScreen');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration Successful'),
              backgroundColor: Colors.green,
            ),
          );
          context.go('/NavigationView');
        } else if (state is RegisterError) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
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

              // Logo
              Center(
                child: Image.asset(
                  'assets/images/72F03EE0-CFF5-4B46-A094-7D804AF927F0.jpeg.PNG',
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.2,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Register Prompt
              FittedBox(
                child: Text(
                  'سجل حساب جديد',
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

              // Form
              Form(
                key: formKey,
                child: Column(
                  children: [
                    // Name Field
                    CustomTextField(
                      taskController: nameController,
                      hint: 'الاسم',
                      validate: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Name mustn\'t be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Email Field
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

                    // Password Field
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

                    // Register Button
                    SizedBox(
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          register(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFF6A7D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'تسجيل',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Login Prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      'ادخل',
                      style: GoogleFonts.pacifico(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffFF6A7D),
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ),
                    onPressed: () {
                      context.pushReplacement('/');
                    },
                  ),
                  Text(
                    'هل لديك حساب ب الفعل ؟',
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      BlocProvider.of<AuthCubit>(context).register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
  }
}

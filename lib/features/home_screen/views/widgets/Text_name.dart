import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../auth/presentation/views_model/auth__cubit.dart';
import '../../../auth/presentation/views_model/auth__state.dart';
import '../../../auth/presentation/views_model/uesr_model.dart';

class TextName extends StatelessWidget {
  const TextName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xffFF4A4C),
              strokeWidth: 2,
            ),
          );
        } else if (state is AuthSuccess || state is RegisterSuccess) {
          UserModel user = (state is AuthSuccess) ? state.user : (state as RegisterSuccess).user;

          return AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: 1.0,
            child: Text(
              '${user.name}، أهلا',
              style: GoogleFonts.lora(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          );
        } else {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: 1.0,
            child: Text(
              'أهلا بك!',
              style: GoogleFonts.lora(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xffFF4A4C),
                  fontSize: 28,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

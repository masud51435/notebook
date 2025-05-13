import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSignInSection extends StatelessWidget {
  const BottomSignInSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have any account?", style: GoogleFonts.poppins()),
        TextButton(
          onPressed: () => context.go('/login'),
          child: Text("LogIn", style: GoogleFonts.poppins()),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpSection extends StatelessWidget {
  const SignUpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have any account?"),
        TextButton(
          onPressed: () => context.push('/signUp'),
          child: const Text("Sign Up"),
        ),
      ],
    );
  }
}

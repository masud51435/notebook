import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controllers/authentication/authentication_repository.dart';

class Frontpage extends StatefulWidget {
  const Frontpage({super.key});

  @override
  State<Frontpage> createState() => _FrontpageState();
}

class _FrontpageState extends State<Frontpage> {
  @override
  void initState() {
    super.initState();
    _initAuth();
  }

  void _initAuth() async {
    await Future.delayed(const Duration(seconds: 1));
    final authRepo = AuthenticationRepository();
    await authRepo.screenRedirect(context); 
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      child: Center(
        child: CupertinoActivityIndicator(color: Colors.black, radius: 30),
      ),
    );
  }
}

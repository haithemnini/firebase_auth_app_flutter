import 'package:flutter/material.dart';

import '../../features/auth/views/views.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool _isSignIn = true;

  @override
  Widget build(BuildContext context) {
    return _isSignIn
        // Login
        ? SignInView(onSignedIn: _toggleView)
        // Register
        : SignUpView(onSignedUp: _toggleView);
  }

  void _toggleView() => setState(() => _isSignIn = !_isSignIn);
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: [
        EmailAuthProvider(),
      ],
      headerBuilder: (context, constraints, _) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Icon(
            Icons.note_alt_outlined,
            size: 80,
            color: Colors.purple[700],
          ),
        );
      },
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: action == AuthAction.signIn
              ? Text(
            'Welcome to Notes App, please sign in!',
            style: TextStyle(
              color: Colors.purple[700],
              fontSize: 16,
            ),
          )
              : Text(
            'Welcome to Notes App, please sign up!',
            style: TextStyle(
              color: Colors.purple[700],
              fontSize: 16,
            ),
          ),
        );
      },
      footerBuilder: (context, _) {
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'By signing in, you agree to our terms and conditions.',
            style: TextStyle(color: Colors.purple[300]),
          ),
        );
      },
      styles: const {
        EmailFormStyle(
          signInButtonVariant: ButtonVariant.filled,
        ),
      },
    );
  }
}


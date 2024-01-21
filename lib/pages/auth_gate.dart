
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:navtern/pages/active_page.dart';
import 'package:navtern/pages/setup.dart';

class AuthGate extends StatefulWidget {

  AuthGate({Key? key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {


  //Welcome, please log in.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Setup();
        }

        return const ActivePage();
      },
    );
  }

  Future<bool> registerProfile(String name, String email, String pass) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      final user = FirebaseAuth.instance.currentUser;
      await user?.updateDisplayName(name);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginProfile(String email, String pass) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return true;
    }
    catch (e) {
      return false;
    }
  }
}

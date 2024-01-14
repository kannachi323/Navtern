import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:navtern/pages/active_page.dart';

class AuthGate extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool hidden = true;
  
  AuthGate({Key? key});
  
  //Welcome, please log in.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Navtern')),
            body: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(64, 18, 64, 18),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(64, 18, 64, 18),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(64, 18, 64, 18),
                    child: TextField(
                      obscureText: hidden,
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => hidden = false,
                          icon: Icon(Icons.visibility),
                        
                          ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "Password",
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //loginProfile(emailController.text, passwordController.text);
                    
                      emailController.clear();
                      passwordController.clear();
                    },
                   child: const Text('Log In'),
                  ),
                ],
              ),
            ),
          );
        }

        return const ActivePage();
      },
    );
  }

  Future registerProfile(String name, String email, String pass) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      final user = FirebaseAuth.instance.currentUser;
      await user?.updateDisplayName(name);
    } catch (e) {
      return Null;
    }
  }

  Future loginProfile(String email, String pass) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
    }
    catch (e) {
      return Null;
    }
  }
}

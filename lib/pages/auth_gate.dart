
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:navtern/pages/active_page.dart';

class AuthGate extends StatefulWidget {

  AuthGate({Key? key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool hidden = true;
  Icon hiddenIcon = Icon(Icons.visibility);

  //Welcome, please log in.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: const Text('Navtern')),
            body: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 5, 32, 5),
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
                    padding: const EdgeInsets.fromLTRB(32, 5, 32, 5),
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
                    padding: const EdgeInsets.fromLTRB(32, 5, 32, 5),
                    child: TextField(
                      obscureText: hidden,
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidden = !hidden;
                              if (hidden) {
                                hiddenIcon = const Icon(Icons.visibility_off);
                              }
                              else {
                                hiddenIcon = const Icon(Icons.visibility);
                              }
                            });
                          },
                          icon: hiddenIcon,
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
                      BuildContext currContext = context;

                      loginProfile(emailController.text, passwordController.text)
                          .then((bool success) {
                          if (!success) {
                            ScaffoldMessenger.of(currContext).showSnackBar(
                              const SnackBar(
                                content: Text("Invalid user details"),
                              ),
                            
                            );
                          }

                        // Clear text fields regardless of success or failure
                        emailController.clear();
                        passwordController.clear();
                      });
                    },
                    child: const Text('Log In'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Don't have a Navtern account?"),
                  TextButton(
                    onPressed: () {
                      print("go to register page");
                    },
                    child: const Text("Sign Up")
                  )
                ],
              ),
            ),
          );
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

import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:navtern/pages/active_page.dart';

//Login

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  bool hidden = true;
  Icon hiddenIcon = const Icon(Icons.visibility_off);

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Navtern')),
      body: _selectedIndex == 0 ? buildLoginPage() : buildRegisterPage(),
      
    );
  }

  Widget buildRegisterPage() {
    return Scaffold(
     
      body: Column(
        children: [
          buildName(),
          buildEmail(),
          buildPassword(),
          buildButton(_selectedIndex),
          const Text("Don't have a Navtern account?"),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            child: const Text("Log In"),
          ),
        ],
      ),
    );
  }

  Widget buildLoginPage() {
    return Scaffold(
      body: Column(
        children: [
          buildEmail(),
          buildPassword(),
          buildButton(_selectedIndex),
          const Text("Don't have a Navtern account?"),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            child: const Text("Sign Up"),
          ),
        ],
      ),
    );
  }

  Widget buildName() {
    return Padding(
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
    );
  }

  Widget buildEmail() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 5, 32, 5),
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: 'Email',
        ),
      ),
    );
  }

  Widget buildPassword() {
    return Padding(
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
    );
  }

  Widget buildButton(int index) {
    return ElevatedButton(
      onPressed: () {
        BuildContext currContext = context;
        if (index == 0) {
          loginProfile(emailController.text, passwordController.text)
              .then((bool success) {
              if (!success) {
                ScaffoldMessenger.of(currContext).showSnackBar(
                  const SnackBar(
                    content: Text("Invalid user details"),
                  ),
                
                );
              }
          });
        }
        else if (index == 1) {
          registerProfile(nameController.text, emailController.text, passwordController.text)
              .then((bool success) {
                
              if (!success) {
                print("did not register");
                ScaffoldMessenger.of(currContext).showSnackBar(
                  const SnackBar(
                    content: Text("Invalid user details"),
                  ),
                
                );
              }
          });
        }
      }, 
      child: index == 0 ? const Text("Log In") : const Text("Sign Up")
    );
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

  Future<bool> registerProfile(String name, String email, String pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      final user = userCredential.user;
      await user?.updateDisplayName(name);
      return true;
    } catch (e) {
      return false;
    }
  }

  
  
}



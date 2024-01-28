import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';


//Login

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  //Login
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  //Register
  final TextEditingController rfnController = TextEditingController();
  final TextEditingController rlnController = TextEditingController();
  final TextEditingController rEmController = TextEditingController();
  final TextEditingController rPassController = TextEditingController();
  
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
          buildName("First Name", rfnController),
          buildName("Last Name", rlnController),
          buildEmail(rEmController),
          buildPassword(rPassController),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            child: const Text("Already have a Navtern account?"),
          ),
          ElevatedButton(
            onPressed: () {
            
              registerProfile(rfnController.text, rlnController.text, 
              rEmController.text)
                  .then((bool success) {
                  if (!success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Invalid user details"),
                      ),
                    
                    );
                  }
              });
            },
          child: const Text("Register"),
          ),
        ]
      ),
    );
  }

  Widget buildLoginPage() {
    return Scaffold(
      body: Column(
        children: [
          buildEmail(emailController),
          buildPassword(passwordController),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            child: const Text("Don't have a Navtern account?")
          ),
          ElevatedButton(
            onPressed: () {
             
                loginProfile(emailController.text, passwordController.text)
                    .then((bool success) {
                    if (!success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Invalid user details"),
                        ),
                      
                      );
                    }
                });
              },
              child: const Text("Log In")
          ),
        ],
      ),
    );
  }

  Widget buildName(String part, TextEditingController controller) {
   
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 5, 32, 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: part,
        ),
      ),
    );
  }

  Widget buildEmail(TextEditingController controller) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 5, 32, 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: 'Email',
        ),
      ),
    );
  }

  Widget buildPassword(TextEditingController controller) {
  
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 5, 32, 5),
      child: TextField(
        obscureText: hidden,
        controller: controller,
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



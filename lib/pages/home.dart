import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Image.asset(
              'assets/images/line.png',
              width: 100,
              height: 100,
              alignment: Alignment.center,
            ),
            ElevatedButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
              },
              child: Text("Sign Out")),
          ]
        ),
      ),
      
    );
  }
}
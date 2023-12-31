import 'package:flutter/material.dart';
import 'package:navtern/pages/mypage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const MyPage(),
      /*routes: {
        '/home': (context) => const HomePage(),
        '/applications': (context) => const ApplicationsPage(),
        '/settings': (context) => const ResultsPage(),
      }*/
    );
  }
}



import 'package:flutter/material.dart';
import 'package:navtern/pages/controller.dart';
import 'package:navtern/pages/results.dart';
import 'package:navtern/pages/search.dart';
import 'package:navtern/pages/help.dart';
import 'package:navtern/pages/about.dart';
import 'package:navtern/pages/applications.dart';
import 'package:navtern/data/service.dart';
import 'package:navtern/data/listing.dart';
import 'dart:async';

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
      routes: {
        '/home': (context) => const SearchPage(),
        '/applications': (context) => const ApplicationsPage(),
        '/settings': (context) => const ResultsPage(),
        '/help': (context) => const HelpPage(),
        '/about': (context) => const AboutPage(),
      }
    );
  }
}



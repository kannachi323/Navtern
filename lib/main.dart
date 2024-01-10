import 'package:flutter/material.dart';
import 'package:navtern/data/service.dart';
import 'package:navtern/pages/active_page.dart';
import 'package:navtern/pages/results.dart';
import 'package:navtern/pages/jobs.dart';
import 'package:navtern/pages/help.dart';
import 'package:navtern/pages/about.dart';
import 'package:navtern/pages/applications.dart';

void main() {
  runApp(const MainApp());
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});
  

  

  @override
  Widget build(BuildContext context) {
    DataService.getJsonData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const ActivePage(),
      routes: {
        '/home': (context) => const JobsPage(),
        '/applications': (context) => const ApplicationsPage(),
        '/settings': (context) => const ResultsPage(),
        '/help': (context) => const HelpPage(),
        '/about': (context) => const AboutPage(),
      }
    );
  }
}



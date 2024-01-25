import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:navtern/data/service.dart';
import 'package:navtern/firebase_options.dart';
import 'package:navtern/pages/results.dart';
import 'package:navtern/pages/jobs.dart';
import 'package:navtern/pages/help.dart';
import 'package:navtern/pages/about.dart';
import 'package:navtern/pages/matches.dart';
import 'package:navtern/pages/auth_gate.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    DataService.getJsonData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => JobsPageState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        home: AuthGate(),
        routes: {
          '/home': (context) => JobsPage(),
          '/applications': (context) => const ApplicationsPage(),
          '/settings': (context) => const ResultsPage(),
          '/help': (context) => const HelpPage(),
          '/about': (context) => const AboutPage(),
        }
      ),
    );
  }
}



import 'package:flutter/material.dart';


class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsState();
}

class _ResultsState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/line.png',
              width: 100,
              height: 100,
              alignment: Alignment.center,
            ),
          ]
        ),
      ),
      
    );
  }
}
import 'package:flutter/material.dart';


class ApplicationsPage extends StatelessWidget {
  const ApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/sheets.png',
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
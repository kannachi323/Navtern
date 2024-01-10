import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:navtern/pages/applications.dart';
import 'package:navtern/pages/jobs.dart';
import 'package:navtern/pages/results.dart';

class ActivePage extends StatefulWidget {
  const ActivePage({super.key});

  @override
  State<ActivePage> createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    const ResultsPage(),
    const JobsPage(),
    const ApplicationsPage(),
    const ResultsPage(),
  ];

  final List<PreferredSizeWidget> _appBars = [
    AppBar(
      title: const Text('Navtern'), 
      scrolledUnderElevation: 0.0),
    AppBar(title: const Text('Jobs'), scrolledUnderElevation: 0.0,),
    AppBar(title: const Text('Applications')),
    AppBar(title: const Text('Results')),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars[_selectedIndex],
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 25),
        child: GNav(
          padding: const EdgeInsets.all(10),
          tabBackgroundColor: Colors.transparent,
          tabActiveBorder: Border.all(color: Colors.black, width: 2),
          gap: 6,
          
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.list_alt,
              text: 'Applications',
            ),
            GButton(
              icon: Icons.insert_chart_outlined,
              text: 'Results',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

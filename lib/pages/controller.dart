import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:navtern/pages/about.dart';
import 'package:navtern/pages/applications.dart';
import 'package:navtern/pages/help.dart';
import 'package:navtern/pages/search.dart';
import 'package:navtern/pages/results.dart';
import 'package:navtern/data/service.dart';
import 'package:navtern/data/listing.dart';
import 'dart:async';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    const ResultsPage(),
    const SearchPage(),
    const ApplicationsPage(),
    const ResultsPage(),
  ];

  final List<PreferredSizeWidget> _appBars = [
    AppBar(title: const Text('Results Page')),
    AppBar(title: const Text('Search Page')),
    AppBar(title: const Text('Applications Page')),
    AppBar(title: const Text('Results Page')),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex != 0 ? _appBars[_selectedIndex] :
        AppBar(
        title: const Text('Navtern'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              _buildScreen('Help');
            },
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              _buildScreen('About');
            },
          ),
        ],
      ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical:10),
          child: GNav(
            padding: const EdgeInsets.all(8),
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

  void _buildScreen(String value) {
    switch (value) {
      case 'About':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutPage()),
        );
        break;
      case 'Help':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HelpPage()),
        );
        break;
    }
  }
}

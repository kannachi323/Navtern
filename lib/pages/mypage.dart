import 'package:flutter/material.dart';
import 'results.dart';
import 'applications.dart';
import 'home.dart';
import 'help.dart';
import 'about.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String _selectedDropdownItem = 'Home';
  String _selectedPopupMenu = 'Home';

  final List<String> dropdownItems = ['Home', 'Applications', 'Results'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            alignment: Alignment.center,
            value: _selectedDropdownItem,
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (String? newValue) {
              setState(() {
                _selectedDropdownItem = newValue ?? 'Home'; // Use 'Home' as default
              });
            },
            items: dropdownItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _selectedPopupMenu = value;
              });
              _buildScreen(_selectedPopupMenu);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Help',
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Help'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'About',
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('About'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: _buildPage(_selectedDropdownItem), // Display pages
    );
  }

  Widget _buildPage(String selectedMenuItem) {
    switch (selectedMenuItem) {
      case 'Home':
        return const HomePage();
      case 'Applications':
        return const ApplicationsPage();
      case 'Results':
        return const ResultsPage();
      default:
        return const HomePage();
    }
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

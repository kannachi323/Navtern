import 'package:flutter/material.dart';
import 'results.dart';
import 'applications.dart';
import 'home.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  get value => null;
  String _selectedMenuItem = 'Home';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            alignment: Alignment.center,
            value: _selectedMenuItem,
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (String? newValue) {
              setState(() {
                _selectedMenuItem = newValue!;
              });
              print('Selected: $_selectedMenuItem');
            },
            items: <String>['Home', 'Applications', 'Results'].map<DropdownMenuItem<String>>((String value){
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
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true, 
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              print('Selected: $value');
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Page 1',
                  child: Text('Page 1'),
                ),
                const PopupMenuItem<String>(
                  value: 'Page 2',
                  child: Text('Page 2'),
                ),
              ];
            },
          ),
        ],
      ),
      body: _buildPage(_selectedMenuItem), //Display pages
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
}
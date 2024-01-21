import 'package:flutter/material.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  List<String> items = ['All', 'Saved', 'In Progress', 'Completed'];
  String? selected = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selected,
                items: items.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                )).toList(),
                onChanged: (String? item) {
                  setState(() {
                    selected = item;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

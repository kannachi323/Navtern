import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:navtern/data/listing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Listing> listings = [];
  int items = 50;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getJsonData();
    Timer.periodic(const Duration(hours: 5), (timer) {
      _getJsonData();
    });
  }

  Future<void> _getJsonData() async {
    final response = await http.get(
        Uri.parse('https://raw.githubusercontent.com/SimplifyJobs/Summer2024-Internships/dev/.github/scripts/listings.json'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      setState(() {
        listings = jsonList.map((jsonObject) => Listing.fromJson(jsonObject)).toList();
        listings = listings.reversed.toList();
       
      });
    } else {
      print("error reading json data");
    }
  }

  @override
 Widget build(BuildContext context) {
  // Return your actual UI here
  return Scaffold(
    body: Column(
      children: <Widget>[
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: items,
              itemBuilder: (context, index) {
                if (index == items - 1 && items < listings.length / 10) {
                  return TextButton(
                    onPressed: () {
                      setState(() {
                        items += 50;
                      });
                    },
                    child: const Text('Load More'),
                  );
                } else if (index < listings.length / 10) {
                  Listing listing = listings[index];
                  return ListTile(
                    title: Text(listing.title),
                    subtitle: Text(listing.companyName),
                  );
                }
                return const SizedBox(); // Placeholder for non-existent item
              },
            ),
          ),
        ),
      ],
      ),
    );
  }
}

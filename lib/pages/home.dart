import 'package:flutter/material.dart';
import 'dart:async';
import 'package:navtern/data/listing.dart';
import 'package:navtern/data/service.dart';
import 'package:navtern/pages/webview.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  List<Listing> listings = [];
  int items = 50;
  final ScrollController _scrollController = ScrollController();
  final DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();
    _loadData();
    Timer.periodic(const Duration(hours: 5), (timer) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    try {
      final newData = await _dataService.getJsonData();
      if (mounted) {
        setState(() {
          listings = newData.reversed.toList();
        });
      }
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
                    return Card(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                        ),
                        child: ExpansionTile(
                          title: Text(listing.title),
                          subtitle: Text(listing.companyName),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: listing.locations.map((location) => Text(location)).toList(),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewPage(url: listing.url),
                                  ),
                                );          
                              },
                              child:
                                const Text("Apply"),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                  
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
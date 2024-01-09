import 'package:flutter/material.dart';
import 'dart:async';
import 'package:navtern/data/listing.dart';
import 'package:navtern/data/service.dart';
import 'package:navtern/pages/webview.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
  
}

class _SearchPageState extends State<SearchPage> {
  List<Listing> listings= [];
  int items = 50;
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    DataService.getJsonData();
    listings = DataService.listings.reversed.toList();

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
                  if (index == items - 1 && items < listings.length) {
                    return TextButton(
                      onPressed: () {
                        setState(() {
                          items += 50;
                        });
                      },
                      child: const Text('Load More'),
                    );
                  } else if (index < listings.length) {
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
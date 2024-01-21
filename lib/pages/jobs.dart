import 'package:flutter/material.dart';
import 'package:navtern/data/listing.dart';
import 'package:navtern/data/service.dart';
import 'dart:math';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  List<Listing> listings = DataService.listings;
  int index = 0;
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          buildListing(),
          buildYesNo(),
        ],
      ),
    );
  }

  Widget buildYesNo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                icon: const Icon(Icons.close),
                iconSize: 80.0,
                onPressed: () {
                  
                  setState(() {
                    index = random.nextInt(51);
                  });
                },
              ),
              IconButton(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                icon: const Icon(Icons.done),
                iconSize: 80.0,
                onPressed: () {
                  print("pressed");
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildListing() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.album),
                title: Text(listings[index].title),
                subtitle: Text(listings[index].companyName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

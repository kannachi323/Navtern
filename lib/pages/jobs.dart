import 'package:flutter/material.dart';
import 'package:navtern/data/listing.dart';
import 'package:navtern/data/service.dart';
import 'package:provider/provider.dart';
import 'dart:math'

class JobsPageState extends ChangeNotifier {
  List<Listing> favorites = [];
  List<int> seen = [0];

  void updateIndex() {
    int newIndex = Random().nextInt(51);
    while (seen.contains(newIndex)) {
      newIndex = Random().nextInt(51);
    }
    JobsPage.index = newIndex;
    seen.add(newIndex);
    notifyListeners();
  }

  void updateProgress() {
    JobsPage.progressValue = favorites.length / JobsPage.goal;
    notifyListeners();
  }

  void addFavorites() {
    print(JobsPage.index.toString());
    Listing current = JobsPage.listings[JobsPage.index];
    if (favorites.contains(current)) {
        favorites.remove(current);
      } else {
        favorites.add(current);
      }
      notifyListeners();
    }

    void removeFavorites(index) {
      favorites.removeAt(index);
      notifyListeners();
    }

    
  }

class JobsPage extends StatelessWidget {
  JobsPage({Key? key});

  static List<Listing> listings = DataService.listings;
  static int index = 0;
  static double progressValue = 0.0;
  static int goal = 23;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<JobsPageState>();

    // Calculate padding based on screen size
    double horizontalPadding = MediaQuery.of(context).size.width * 0.03; // 5% of screen width
    double verticalPadding = MediaQuery.of(context).size.height * 0.03; // 5% of screen height

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Text(
                  "Goal",
                  // textScaler: TextScaler.linear(1.3), // Make sure this is defined somewhere
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: horizontalPadding),
                child: LinearProgressIndicator(
                  value: progressValue,
                  minHeight: 10,
                  backgroundColor: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 200),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.work),
                        title: Text(listings[index].title),
                        subtitle: Text(listings[index].companyName),
                        trailing: Text(listings[index].locations.toString()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.6),
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                      icon: const Icon(Icons.close),
                      iconSize: 80.0,
                      onPressed: () {
                        state.updateIndex();
                      },
                    ),
                    IconButton(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                      icon: const Icon(Icons.done),
                      iconSize: 80.0,
                      onPressed: () {
                        state.addFavorites();
                        state.updateIndex();
                        state.updateProgress();
                      },
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}

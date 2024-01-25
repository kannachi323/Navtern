import 'package:flutter/material.dart';
import 'package:navtern/data/listing.dart';
import 'package:navtern/data/service.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class JobsPageState extends ChangeNotifier {
  List<Listing> favorites = [];

  void updateIndex(int newIndex) {
    JobsPage.index = newIndex;
    notifyListeners();
  }

  void toggleFavorites() {
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
  JobsPage({super.key});

  static List<Listing> listings = DataService.listings;

  static int index = 0;

  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    var state = context.watch<JobsPageState>();
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          
          
          Column(
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
                        state.updateIndex(Random().nextInt(51));
                      },
                    ),
                    IconButton(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                      icon: const Icon(Icons.done),
                      iconSize: 80.0,
                      onPressed: () {
                        state.toggleFavorites();
                        state.updateIndex(Random().nextInt(51));
                        
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
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
          ),


        ],
      ),
    );
  }

}
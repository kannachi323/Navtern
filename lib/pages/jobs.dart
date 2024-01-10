import 'package:flutter/material.dart';
import 'package:navtern/data/listing.dart';
import 'package:navtern/data/service.dart';
import 'package:navtern/pages/webview.dart';
import 'package:implicitly_animated_reorderable_list_2/implicitly_animated_reorderable_list_2.dart';
import 'package:implicitly_animated_reorderable_list_2/transitions.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';


class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  List<Listing> listings = DataService.listings;
  List<Listing> filteredListings = [];
  int items = 50;
  final ScrollController _scrollController = ScrollController();
  final FloatingSearchBarController _searchController = FloatingSearchBarController();
  
  void filter(String query) {
    setState(() {
    filteredListings = listings
      .where((listing) =>
          listing.title.toLowerCase().contains(query.toLowerCase()) ||
          listing.companyName.toLowerCase().contains(query.toLowerCase()) ||
          listing.locations.any((location) =>
              location.toLowerCase().contains(query.toLowerCase())))
      .toList();
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    // This is handled by the search bar itself.
    resizeToAvoidBottomInset: false,
    body: Stack(
      fit: StackFit.expand,
      children: [
        buildListings(),
        buildSearchBar(),

      ],
    ),
  );
  }

  Widget buildListings() {
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

  Widget buildSearchBar() {
    return FloatingSearchBar(
      height: 60.0,
      
      scrollPadding: const EdgeInsets.fromLTRB(0,5,0,48),
      autocorrect: true,
      backdropColor: Colors.transparent,
      iconColor: Colors.blue,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      hint: 'Search...',
      physics: const NeverScrollableScrollPhysics(),
      transitionDuration: const Duration(milliseconds:300),
      transitionCurve: Curves.bounceOut,
      
      openAxisAlignment: 0.0,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        filter(query);
      },
      clearQueryOnClose: false,
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      closeOnBackdropTap: true,
      transition: CircularFloatingSearchBarTransition(),
      automaticallyImplyBackButton: true,
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
          
            onPressed: () {
              
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: .0,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Result $index"),
                  tileColor: Colors.white, // Set the color to white
                  onTap: () {
                    // Handle the click on the search result
                    print("Clicked on Result $index");
                  },
                );
              },
            ),
          ),
        );
      }
    );
  }
}
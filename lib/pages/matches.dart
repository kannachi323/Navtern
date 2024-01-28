import 'package:flutter/material.dart';
import 'package:navtern/pages/jobs.dart';
import 'package:navtern/pages/webview.dart';
import 'package:provider/provider.dart';


class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<JobsPageState>();

    if (state.favorites.isEmpty) {
      return const Center(
        child: Text("Darn, you have no matches yet!"),
      );
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: state.favorites.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: UniqueKey(),
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm"),
                    content: const Text("Are you sure you want to delete this?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          setState(() {
                            state.removeFavorites(index);
                            state.updateProgress();
                            Navigator.pop(context, true);
                          });
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  );
                },
              );
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.work),
                      title: Text(state.favorites[index].title),
                      subtitle: Text(state.favorites[index].companyName),
                      
                    ),
                                 ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebViewPage(url: state.favorites[index].url),
                                    ),
                                  );          
                                },
                                child:
                                  const Text("Apply"),
                              )
                      
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

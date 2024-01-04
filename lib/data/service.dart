// data_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:navtern/data/listing.dart';

class DataService {
  List<Listing> cachedListings = [];

  

  Future<List<Listing>> getJsonData() async {
    
    if (cachedListings.isNotEmpty) {
      return cachedListings;
    }

    final response = await http.get(
      Uri.parse(
          'https://raw.githubusercontent.com/SimplifyJobs/Summer2024-Internships/dev/.github/scripts/listings.json'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      cachedListings = jsonList.map((jsonObject) => Listing.fromJson(jsonObject)).toList();
      return cachedListings;
    } else {
      throw Exception("Error reading JSON data");
    }
  }
}

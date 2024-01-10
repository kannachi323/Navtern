// data_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:navtern/data/listing.dart';

class DataService {
  static List<Listing> listings = [];

  

  static Future getJsonData() async {

    final response = await http.get(
      Uri.parse(
          'https://raw.githubusercontent.com/SimplifyJobs/Summer2024-Internships/dev/.github/scripts/listings.json'),
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      listings = jsonList.map((jsonObject) => Listing.fromJson(jsonObject)).toList();
      listings = listings.reversed.toList();
    } else {
      throw Exception("Error reading JSON data");
    }
  }

  


}

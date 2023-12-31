import 'dart:convert';

Listing listingFromJson(String str) => Listing.fromJson(json.decode(str));

String listingToJson(Listing data) => json.encode(data.toJson());


class Listing {
  String source;
  String companyName;
  String id;
  String title;
  bool active;
  List<String> terms;
  int dateUpdated;
  int datePosted;
  String url;
  List<String> locations;
  String companyUrl;
  bool isVisible;
  String sponsorship;

  Listing ({
      required this.source,
        required this.companyName,
        required this.id,
        required this.title,
        required this.active,
        required this.terms,
        required this.dateUpdated,
        required this.datePosted,
        required this.url,
        required this.locations,
        required this.companyUrl,
        required this.isVisible,
        required this.sponsorship,
  });

  factory Listing.fromJson(Map<String, dynamic> json) => Listing (
    source: json["source"],
    companyName: json["company_name"],
    id: json["id"],
    title: json["title"],
    active: json["active"],
    terms: List<String>.from(json["terms"].map((x) => x)),
    dateUpdated: json["date_updated"],
    datePosted: json["date_posted"],
    url: json["url"],
    locations: List<String>.from(json["locations"].map((x) => x)),
    companyUrl: json["company_url"],
    isVisible: json["is_visible"],
    sponsorship: json["sponsorship"],
  );

  Map<String, dynamic> toJson() => {
    "source": source,
    "company_name": companyName,
    "id": id,
    "title": title,
    "active": active,
    "terms": List<dynamic>.from(terms.map((x) => x)),
    "date_updated": dateUpdated,
    "date_posted": datePosted,
    "url": url,
    "locations": List<dynamic>.from(locations.map((x) => x)),
    "company_url": companyUrl,
    "is_visible": isVisible,
    "sponsorship": sponsorship,
};

}
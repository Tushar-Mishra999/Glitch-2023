import 'dart:convert';

class Company {
  final String name;
  final String price;
  final String sentiment;
  final String priceBand;
  final List<Map<String, String>> reports;
  final List<double> prices;

  Company(
      {required this.name,
      required this.price,
      required this.sentiment,
      required this.priceBand,
      required this.reports,
      required this.prices});

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
        name: map['name'] ?? '',
        price: map['price'] ?? '',
        sentiment: map['sentiment'] ?? '',
        priceBand: map['priceBand'] ?? '',
        reports: map['reports'] ?? '',
        prices:map['prices']??[]);
  }
}

import 'dart:convert';

class Company {
  final String name;
  final String price;
  final double sentimentScore;
  final List<String> reports;
  final List<double> prices;

  Company(
      {required this.name,
      required this.price,
      required this.sentimentScore,
      required this.reports,
      required this.prices});

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
        name: map['name'] ?? '',
        price: map['price'] ?? '',
        sentimentScore: map['sentiment'] ?? '',
        reports: map['reports'] ?? '',
        prices:map['prices']??[]);
  }
}

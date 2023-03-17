import 'dart:convert';

class Nifty {
  final String name;
  final String price;

  Nifty({required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price};
  }

  factory Nifty.fromMap(Map<String, dynamic> map) {
    return Nifty(
        name: map['meta']['symbol'] ?? '',
        price: map['lastPrice'].toString() ?? '',);
  }

  String toJson() => json.encode(toMap());

  factory Nifty.fromJson(String source) => Nifty.fromMap(json.decode(source));

}

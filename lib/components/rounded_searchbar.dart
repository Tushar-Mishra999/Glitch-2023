import 'package:flutter/material.dart';
import 'package:glitch_stock_market/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onSubmitted;

  const RoundedSearchBar({
    Key? key,
    required this.hintText,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color2,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color.fromARGB(255, 176, 176, 176)),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
               style:GoogleFonts.sourceSansPro(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 176, 176, 176))),
            ),
          ),
        ],
      ),
    );
  }
}

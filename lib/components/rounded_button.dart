import 'package:flutter/material.dart';
import 'package:glitch_stock_market/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
      required this.title,
      required this.size,
      required this.func,
      required this.second})
      : super(key: key);

  final size;
  final title;
  final func;
  final second;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
          width: size.width * 0.8,
          height: size.height * 0.07,
          decoration: BoxDecoration(
              color: second ? kBgColor : color1,
              border: Border.all(
                  color: second ? color1 : Colors.transparent,
                  width: second ? 3 : 0),
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.sourceSansPro(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: second ? color1 : Colors.black,
              ),
            ),
          )),
    );
  }
}

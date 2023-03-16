import 'package:flutter/material.dart';
import 'package:glitch_stock_market/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/rounded_searchbar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Image.asset(
                "assets/money.png",
                width: size.width * 0.5,
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              RoundedSearchBar(
                hintText: 'Search for your company',
                onChanged: (value) {
                  // Handle search query
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 30.0, right: 30, top: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'NIFTY 100',
                      style: GoogleFonts.sourceSansPro(
                          color: Colors.grey.shade100,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "\$50",
                      style: GoogleFonts.sourceSansPro(
                          color: Colors.transparent,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    )
                  ],
                ),
              ),
              for (int i = 0; i < 2; i++)
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30.0, right: 30, top: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ambuja Cement',
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.grey.shade400, fontSize: 20),
                          ),
                          Text(
                            "\$50",
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.green.shade500,
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Adani Enterprises',
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.grey.shade400, fontSize: 20),
                          ),
                          Text(
                            "\$69",
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.red.shade500,
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                    )
                  ],
                ),
            ]),
          ),
        ),
      ),
    );
  }
}

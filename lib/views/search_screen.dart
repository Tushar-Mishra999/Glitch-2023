import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glitch_stock_market/constants.dart';
import 'package:glitch_stock_market/models/company.dart';
import 'package:glitch_stock_market/services/search-service.dart';
import 'package:glitch_stock_market/views/info_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/rounded_searchbar.dart';
import '../models/nifty100.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Nifty> niftyList = [];
  bool isLoaded1 = false;
  bool isLoaded2 = true;
  void fetchNifty() async {
    SearchService searchService = SearchService();
    niftyList = await searchService.getNifty();
    isLoaded1 = false;
    setState(() {});
  }

  void fetchCompany(String name, BuildContext context) async {
    isLoaded2 = true;
    setState(() {
    });
    SearchService searchService = SearchService();
    Company company = await searchService.searchCompany(companyName: name);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InfoScreen(
                  company: company,
                )));
    
    isLoaded2 = false;
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    // fetchNifty();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Stack(
          children:[ SingleChildScrollView(
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
                  onSubmitted: (value) {
                    fetchCompany(value, context);
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30, top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Gainers',
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
                isLoaded1
                    ? const CircularProgressIndicator(color: color1)
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            niftyList.length, // the number of items in the list
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30, top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  niftyList[index].name,
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.grey.shade400, fontSize: 20),
                                ),
                                Text(
                                  niftyList[index].price,
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.green.shade500,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                          );
                        },
                      )
              ]),
            ),
          ),
          isLoaded2
                    ? Center(child: const CircularProgressIndicator(color: color1)):Container()
          ]
        ),
      ),
    );
  }
}

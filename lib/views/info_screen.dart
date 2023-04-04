import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glitch_stock_market/constants.dart';
import 'package:glitch_stock_market/services/search-service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/company.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({super.key, required this.company});
  Company company;
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  //List<double> prices = [1001, 1002, 500, 400, 200, 800, 950];

  bool isLoaded = true;
  

  // Feature(
  @override
  Widget build(BuildContext context) {
    List<double> prices = widget.company.prices;
    double maxi = -1;

    for (int i = 0; i < prices.length; i++) {
      maxi = maxi < prices[i] ? prices[i] : maxi;
    }
    for (int i = 0; i < prices.length; i++) {
      prices[i] = prices[i] / maxi;
    }

    final List<Feature> features = [
      Feature(
        title: "Drink Water",
        color: Colors.blue,
        data: prices,
      ),
    ];
    final List<double> labelYNum = [];
    double firstnum = maxi / 5;
    labelYNum.add(firstnum);

    for (int i = 1; i < 4; i++) {
      var num = labelYNum[i - 1];
      labelYNum.add(num + firstnum);
    }
    labelYNum.add(maxi);
    final List<String> labely = [];

    for (int i = 0; i < 5; i++) {
      labely.add(labelYNum[i].toStringAsFixed(2));
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.company.name,
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 25,
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\u{20B9}${widget.company.price}",
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 22,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  Text(
                    "Sentiment: ",
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 22,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w700),
                  ),
                  widget.company.sentimentScore > 0
                      ? Text(
                          "Positive",
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 22,
                              color: Colors.green.shade400,
                              fontWeight: FontWeight.w700),
                        )
                      : widget.company.sentimentScore == 0
                          ? Text(
                              "Neutral",
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 22,
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w700),
                            )
                          : Text(
                              "Negative",
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 22,
                                  color: Colors.red.shade400,
                                  fontWeight: FontWeight.w700),
                            ),
                  Icon(
                    Icons.arrow_upward_sharp,
                    color: Colors.green.shade400,
                  )
                ],
              ),
            ),
            SizedBox(height: size.height * 0.05),
            LineGraph(
              features: features,
              size: Size(size.width * 1, size.height * 0.4),
              labelX: const [
                'Day 1',
                'Day 2',
                'Day 3',
                'Day 4',
                'Day 5',
                'Day 6',
                'Day 7'
              ],
              labelY: labely,
              graphColor: Colors.white30,
              graphOpacity: 0.3,
              verticalFeatureDirection: true,
              descriptionHeight: 130,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30, top: 20, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Confidence Score :',
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.grey.shade100,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "${widget.company.sentimentScore * 100}%",
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.green.shade400,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30, top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Reports',
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget
                  .company.reports.length, // the number of items in the list
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30, top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Uri.parse(widget.company.reports[index])
                            .host
                            .split('.')[1],
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.grey.shade400, fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var url = widget.company.reports[index];
                          if (await canLaunchUrl(Uri.parse(uri))) {
                            await launchUrl(Uri.parse(uri));
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Encountered some error . Please try again");
                          }
                        },
                        child: const Icon(
                          Icons.open_in_browser,
                          color: Colors.blue,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}

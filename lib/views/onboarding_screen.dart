import 'package:flutter/material.dart';
import 'package:glitch_stock_market/constants.dart';
import 'package:glitch_stock_market/views/login_screen.dart';
import 'package:glitch_stock_market/views/registration_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/rounded_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/arrow.png',
                width: size.width * 0.7,
              ),
              // child: SvgPicture.asset(
              //   "assets/gradhatns.svg",
              //   width: size.width * 0.6,
              // ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Center(
                child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Stock",
                    style: GoogleFonts.sourceSansPro(
                      color: color1,
                      fontSize: 50,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  TextSpan(
                    text: "Pulse",
                    style: GoogleFonts.sourceSansPro(
                      color: color1,
                      fontSize: 50,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Stay informed with StockPulse\n and make better investment decisions.',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.sourceSansPro(
                  color: Colors.grey.shade700,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedButton(
              title: "Login",
              size: size,
              second: false,
              func: () {
                Navigator.push(
                  context,MaterialPageRoute(builder: (context)=>LoginScreen())
                );
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            RoundedButton(
              title: "Register",
              size: size,
              second: true,
              func: () {
                Navigator.push(
                  context,MaterialPageRoute(builder: (context)=>RegistrationScreen())
                 );
              },
            ),
          ],
        ),
      ),
    );
  }
}

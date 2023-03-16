import 'package:flutter/material.dart';
import 'package:glitch_stock_market/constants.dart';
import 'package:glitch_stock_market/views/registration_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/rounded_button.dart';
import '../components/textformfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgColor,
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  CustomTextField(
                    title: "Email",
                    controller: emailController,
                    hintText: "Enter your email",
                  ),
                  CustomTextField(
                    title: "Password",
                    controller: passwordController,
                    hintText: "Enter your password",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundedButton(
                    size: size,
                    title: 'Login',
                    func: () {},
                    second: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: (){
                          Navigator.push(
                  context,MaterialPageRoute(builder: (context)=>RegistrationScreen())
                );
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: GoogleFonts.sourceSansPro(
                                color: color1,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "Register",
                              style: GoogleFonts.sourceSansPro(
                                color: color1,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

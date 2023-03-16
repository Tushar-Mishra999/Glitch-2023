import 'package:flutter/material.dart';
import 'package:glitch_stock_market/constants.dart';
import 'package:glitch_stock_market/services/auth-service.dart';
import 'package:glitch_stock_market/views/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/rounded_button.dart';
import '../components/textformfield.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final nameController = TextEditingController();

  final passwordController = TextEditingController();

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgColor,
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      CustomTextField(
                        title: "Name",
                        controller: nameController,
                        hintText: "Enter your name",
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
                        title: 'Register',
                        func: () {
                          isLoaded = true;
                          setState(() {});
                          AuthService authService = AuthService();
                          authService.signUpUser(
                              context: context,
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text);
                          isLoaded = false;
                          setState(() {});
                        },
                        second: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Already have an account? ",
                                  style: GoogleFonts.sourceSansPro(
                                    color: color1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: "Login",
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
                    isLoaded?const CircularProgressIndicator(
                      color: color1,
                    ):Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:glitch_stock_market/constants.dart';
import 'package:glitch_stock_market/services/auth-service.dart';
import 'package:glitch_stock_market/views/registration_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/rounded_button.dart';
import '../components/textformfield.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBgColor,
      body: Stack(children: [
        Center(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      obscure: true,
                      controller: passwordController,
                      hintText: "Enter your password",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    RoundedButton(
                      size: size,
                      title: 'Login',
                      func: () async {
                        isLoaded = true;
                        setState(() {});
                        AuthService authService = AuthService();
                        await authService.signInUser(
                            context: context,
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
                                  builder: (context) => RegistrationScreen()));
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
        isLoaded
            ? const Center(
                child: CircularProgressIndicator(
                  color: color1,
                ),
              )
            : Container()
      ]),
    );
  }
}

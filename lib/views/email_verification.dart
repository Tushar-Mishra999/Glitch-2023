import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glitch_stock_market/constants.dart';
import 'package:glitch_stock_market/views/search_screen.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  late Timer timer;
  late User user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = FirebaseAuth.instance.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Fluttertoast.showToast(
          msg: "Registration Successful", backgroundColor: color1);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kBgColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "A verification link has been sent to ${user.email}, please verify it.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade400,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              GestureDetector(
                  onTap: () {
                    user.sendEmailVerification();
                  },
                  child: Container(
                    width: size.width * 0.7,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: color1,
                    ),
                    child: Center(
                      child: Text(
                        'Send another link',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}

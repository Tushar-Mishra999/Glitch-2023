import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glitch_stock_market/constants.dart';
import 'package:glitch_stock_market/views/email_verification.dart';
import 'package:glitch_stock_market/views/login_screen.dart';
import 'package:http/http.dart' as http;

import '../views/search_screen.dart';

class AuthService {
  Future<void> signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    // try {
    // User user = User(
    //     id: '',
    //     name: name,
    //     email: email,
    //     password: password,
    //     address: address,
    //     type: userType,
    //     token: '',
    //     cart: []);

    //   http.Response res = await http.post(
    //     Uri.parse('api/signup'),
    //     body: jsonEncode({'email': email, 'password': password, 'name': name}),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => SearchScreen()));
    //   // httpErrorHandle(
    //   //     response: res,
    //   //     context: context,
    //   //     onSuccess: () {
    //   //       showSnackBar(context, 'Account has been created');
    //   //     });
    // } catch (e) {
    //   Fluttertoast.showToast(msg: e.toString());
    // }

    String? errorMessage;
    final auth = FirebaseAuth.instance;
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .catchError((e) {
        throw e;
      });
      final docUser = FirebaseFirestore.instance.collection('users').doc(email);
      final emailData = {'email': email, 'name': name};
      await docUser.set(emailData);
      
             Navigator.push(
          context, MaterialPageRoute(builder: (context) => EmailVerification()));
     
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage,toastLength: Toast.LENGTH_LONG,
          backgroundColor: color1);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong, please try again',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: color1);
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
   // try {
    //   http.Response res = await http.post(
    //     Uri.parse('/api/signin'),
    //     body: jsonEncode({
    //       'email': email,
    //       'password': password,
    //     }),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //   );

    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => SearchScreen()));
    //   // httpErrorHandle(
    //   //   response: res,
    //   //   context: context,
    //   //   onSuccess: () async {
    //   //     SharedPreferences prefs = await SharedPreferences.getInstance();
    //   //     Provider.of<UserProvider>(context, listen: false).setUser(res.body);
    //   //     await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
    //   //     if (json.decode(res.body)['type'] == 'user') {
    //   //       Navigator.pushNamedAndRemoveUntil(
    //   //         context,
    //   //         BottomBar.routeName,
    //   //         (route) => false,
    //   //       );
    //   //     } else {
    //   //       Navigator.pushNamedAndRemoveUntil(
    //   //         context,
    //   //         AdminScreen.routeName,
    //   //         (route) => false,
    //   //       );
    //   //     }
    //   //   },
    //   // );
    // } catch (e) {
    //   Fluttertoast.showToast(msg: e.toString());
    // }

    final auth = FirebaseAuth.instance;
    String? errorMessage;
      try {
        final user = await auth.signInWithEmailAndPassword(
            email: email, password: password).catchError((e) {
        throw e;
      });
       
        Fluttertoast.showToast(
            msg: "Login Successful",
            backgroundColor: color1);
       Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => SearchScreen()),(route)=>false);
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
         Fluttertoast.showToast(msg: errorMessage,toastLength: Toast.LENGTH_LONG,
          backgroundColor: color1);
      } catch (e) {
        Fluttertoast.showToast(
            msg: 'Something went wrong, please try again',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: color1);
      }
  }
}

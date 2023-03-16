// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class AuthService {
//   void signUpUser({
//     required BuildContext context,
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       // User user = User(
//       //     id: '',
//       //     name: name,
//       //     email: email,
//       //     password: password,
//       //     address: address,
//       //     type: userType,
//       //     token: '',
//       //     cart: []);

//       http.Response res = await http.post(
//         Uri.parse('$uri/api/signup'),
//         body: jsonEncode({'email': email, 'password': password, 'name': name}),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );

//       // httpErrorHandle(
//       //     response: res,
//       //     context: context,
//       //     onSuccess: () {
//       //       showSnackBar(context, 'Account has been created');
//       //     });
//     } catch (e) {
//       // showSnackBar(context, e.toString());
//     }
//   }

//   void signInUser({
//     required BuildContext context,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/api/signin'),
//         body: jsonEncode({
//           'email': email,
//           'password': password,
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       // httpErrorHandle(
//       //   response: res,
//       //   context: context,
//       //   onSuccess: () async {
//       //     SharedPreferences prefs = await SharedPreferences.getInstance();
//       //     Provider.of<UserProvider>(context, listen: false).setUser(res.body);
//       //     await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
//       //     if (json.decode(res.body)['type'] == 'user') {
//       //       Navigator.pushNamedAndRemoveUntil(
//       //         context,
//       //         BottomBar.routeName,
//       //         (route) => false,
//       //       );
//       //     } else {
//       //       Navigator.pushNamedAndRemoveUntil(
//       //         context,
//       //         AdminScreen.routeName,
//       //         (route) => false,
//       //       );
//       //     }
//       //   },
//       // );
//     } catch (e) {
//       // showSnackBar(context, e.toString());
//     }
//   }
// }

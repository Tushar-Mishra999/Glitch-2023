import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glitch_stock_market/constants.dart';
import 'package:glitch_stock_market/models/company.dart';
import 'package:glitch_stock_market/models/nifty100.dart';
import 'package:http/http.dart' as http;

class SearchService {
  Future searchCompany({required String companyName}) async {
    try {
      http.Response res = await http.get(
        Uri.parse('$uri?companyName=$companyName'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var response = jsonDecode(res.body);
      Company company = Company.fromMap(response);
      return company;
    } catch (e) {}
  }

  Future<List<Nifty>> getNifty() async {
    http.Response res = await http.get(
      Uri.parse(
          '$uri/topmovers'),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
    );

    var response = jsonDecode(res.body);
    print(response);
    List<Nifty> niftyList = [];

    for (var i = 0; i < response.length; i++) {
      Nifty temp = Nifty.fromMap(response[i]);
      niftyList.add(temp);
    }

    return niftyList;
  }
}

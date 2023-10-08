import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes/constants/endpoint.dart';
import 'package:notes/screens/LogIn.dart';
import 'package:notes/screens/Notes.dart';
import '../helpers/SharedPreferencesManager.dart';
import '../reusable/AlertDialog.dart';

class LogInController {

  login(String email, String password ,BuildContext context) async {
    log("message");
    final response = await http.post(
      Uri.parse(APICall().apiLogin),
      body: {
        'email': email,
        'password': password,
      },
    );
    log(response.body.toString());
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body)['data'];

  log(result.toString());
        SharedPreferencesManager.setString('token', result['token'].toString());
       SharedPreferencesManager.setString('email', result['email'].toString());

        Navigator.push(context, MaterialPageRoute(builder: (context) => Notes()));
    } else{
      log("error");

      showAlertDialog(context);
    }
  }

}
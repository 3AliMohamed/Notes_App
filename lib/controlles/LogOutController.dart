
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:notes/constants/endpoint.dart';
import 'package:notes/helpers/SharedPreferencesManager.dart';

class LogOutController {

  logout(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse(APICall().apiLogout),
        headers: {
          'Authorization': 'Bearer $authToken', // Include your authorization header here.
          'Content-Type': 'application/json', // Adjust the content type as needed.
        },
      );

      if (response.statusCode == 200) {
          await SharedPreferencesManager().clearUserSession();

      } else {
        print('Logout failed: ${response.statusCode}');
        // return false;
      }
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}

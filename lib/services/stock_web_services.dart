import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

/// Handles everything related to [InStockPage]
///

class StockWebServices {
  final _headers = {"Content-Type": "application/json"};

  Future<bool> addNewData({required Map<String, dynamic> userInput}) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/instock/addNew'),
      headers: _headers,
      body: json.encode(userInput),
    );
    if (response.statusCode == 200) {
      log("Response: $response");

      return true;
    } else {
      log("Something went wrong");
      return false;
    }
  }
}

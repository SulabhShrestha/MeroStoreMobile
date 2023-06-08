import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:merostore_mobile/models/sales_model.dart';
import 'package:merostore_mobile/views/today_sold_page/today_sold_page.dart';

/// Handles everything related to [TodaySoldPage]
///
class SalesWebServices{
  final _headers = {"Content-Type": "application/json"};

  /// Adds new sales to the database
  Future<bool> addNew({required Map<String, dynamic> userInput}) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/sales/addNew'),
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

  /// Returns all the sales record
  Future<List<Sales>> getAllSalesRecords() async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:3000/instock/"),
      headers: _headers,
    );

    List<Sales> stocks = [];

    if (response.statusCode == 200) {
      log("Response: ${response.body}");
      for (Map<String, dynamic> elem in jsonDecode(response.body)) {
        stocks.add(Sales.fromJSON(elem));
      }
    } else {
      log("Something went wrong");
    }

    return stocks;
  }
}
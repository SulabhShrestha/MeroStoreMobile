import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:merostore_mobile/models/stock_model.dart';

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

  Future<List<Stock>> getAllStocks() async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:3000/instock/"),
      headers: _headers,
    );

    List<Stock> stocks = [];

    if (response.statusCode == 200) {
      log("Response: ${response.body}");
      for (Map<String, dynamic> elem in jsonDecode(response.body)) {
        stocks.add(Stock.fromJSON(elem));
      }
    } else {
      log("Something went wrong");
    }

    return stocks;
  }

  Future<List<String>> getAllMaterialNames({required String storeName}) async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:3000/instock/materialNames/$storeName"),
      headers: _headers,
    );

    List<String> names = [];

    if (response.statusCode == 200) {
      log("Response: ${response.body}");
      for (String elem in jsonDecode(response.body)) {
        names.add(elem);
      }
    } else {
      log("Something went wrong");
    }

    return names;
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:merostore_mobile/models/stock_model.dart';

/// Handles everything related to [InStockPage]
///

class StockWebServices {
  final _headers = {"Content-Type": "application/json"};

  /// Adding new data to the db
  Future<bool> addNewData({required Map<String, dynamic> userInput}) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/instock/add'),
      headers: _headers,
      body: json.encode(userInput),
    );

    if (response.statusCode == 201) {
      log("Response: $response");

      return true;
    } else {
      return false;
    }
  }

  /// Returns all the stocks
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

  /// Getting all the material names from the db according to storeName
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

  /// Returns material details of specific store based on material provided
  Future<Map> getMaterialDetails(
      {required String storeName, required materialName}) async {
    final response = await http.get(
      Uri.parse(
          "http://10.0.2.2:3000/instock/materialDetails/$storeName/$materialName"),
      headers: _headers,
    );

    final jsonDecoded = jsonDecode(response.body);

    return jsonDecoded;
  }
}

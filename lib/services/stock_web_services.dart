import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:merostore_mobile/models/stock_model.dart';
import 'package:merostore_mobile/services/local_storage_services.dart';
import 'package:merostore_mobile/utils/constants/urls_constant.dart';

/// Handles everything related to [InStockPage]
///

class StockWebServices {
  final _urls = UrlsConstant();

  /// Adding new data to the db
  Future<bool> addNewData({required Map<String, dynamic> userInput}) async {
    var token = await LocalStorageServices().getId();
    final response = await http.post(
      Uri.parse(_urls.addStockUrl),
      headers: {
        ..._urls.headers,
        "Authorization": token,
      },
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
    var token = await LocalStorageServices().getId();
    final response = await http.get(
      Uri.parse(_urls.allStocksUrl),
      headers: {
        ..._urls.headers,
        "Authorization": token,
      },
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
    var token = await LocalStorageServices().getId();
    final response = await http.get(
      Uri.parse("${_urls.allMaterialNamesUrl}/$storeName"),
      headers: {
        ..._urls.headers,
        "Authorization": token,
      },
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
    var token = await LocalStorageServices().getId();
    final response = await http.get(
      Uri.parse("${_urls.materialDetailsUrl}/$storeName/$materialName"),
      headers: {
        ..._urls.headers,
        "Authorization": token,
      },
    );

    final jsonDecoded = jsonDecode(response.body);

    return jsonDecoded;
  }
}

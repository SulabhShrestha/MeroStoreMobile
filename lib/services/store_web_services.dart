import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:merostore_mobile/models/store_model.dart';
import 'package:merostore_mobile/utils/constants/urls_constant.dart';

/// [StoreWebServices] handles everything related to store
///

class StoreWebServices {
  final _urls = UrlsConstant();

  Future<Map<String, dynamic>> addNewStore(
      {required Map<String, dynamic> newStore}) async {
    final response = await http.post(
      Uri.parse(_urls.addStoreUrl),
      headers: _urls.headers,
      body: json.encode(newStore),
    );
    if (response.statusCode == 200) {
      log("Response res: ${jsonDecode(response.body)}");

      return {
        "isSaved": true,
        "savedStore": Store.fromJSON(jsonDecode(response.body)["newStore"])
      };
    } else {
      log("Something went wrong");
      return {
        "isSaved": false,
      };
    }
  }

  Future<List<Store>> getAllStores() async {
    final response = await http.get(
      Uri.parse(_urls.allStoresUrl),
      headers: _urls.headers,
    );

    List<Store> stocks = [];

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      for (Map<String, dynamic> elem in body) {
        stocks.add(Store.fromJSON(elem));
      }
    } else {
      log("Something went wrong");
    }
    log("Response: $stocks");
    return stocks;
  }
}

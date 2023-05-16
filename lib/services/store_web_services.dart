import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:merostore_mobile/models/store.dart';

/// [StoreWebServices] handles everything related to store
///

class StoreWebServices {
  final _headers = {"Content-Type": "application/json"};

  Future<bool> addNewStore({required Map<String, dynamic> newStore}) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/store/addNew'),
      headers: _headers,
      body: json.encode(newStore),
    );
    if (response.statusCode == 200) {
      log("Response: $response");

      return true;
    } else {
      log("Something went wrong");
      return false;
    }
  }

  Future<List<Store>> getAllStores() async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:3000/store/"),
      headers: _headers,
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

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:merostore_mobile/models/store_model.dart';
import 'package:merostore_mobile/utils/constants/urls_constant.dart';

import 'local_storage_services.dart';

/// [StoreWebServices] handles everything related to store
///

class StoreWebServices {
  final _urls = UrlsConstant();

  Future<Map<String, dynamic>> addNewStore(
      {required Map<String, dynamic> newStore}) async {
    var token = await LocalStorageServices().getId();
    final response = await http.post(
      Uri.parse(_urls.addStoreUrl),
      headers: {
        ..._urls.headers,
        "Authorization": token,
      },
      body: json.encode(newStore),
    );
    if (response.statusCode == 201) {
      return {
        "isSaved": true,
        "savedStore": StoreModel.fromJSON(jsonDecode(response.body))
      };
    } else {
      log("Something went wrong ${response.statusCode}");
      return {
        "isSaved": false,
      };
    }
  }

  Future<List<StoreModel>> getAllStores() async {
    var token = await LocalStorageServices().getId();
    log("TOken: $token");
    log("url: ${{
      ..._urls.headers,
      "Authorization": token,
    }}, URL : ${Uri.parse(_urls.allStoresUrl)}");
    final response = await http.get(
      Uri.parse(_urls.allStoresUrl),
      headers: {
        ..._urls.headers,
        "Authorization": token,
      },
    );

    List<StoreModel> stocks = [];

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      for (Map<String, dynamic> elem in body) {
        stocks.add(StoreModel.fromJSON(elem));
      }
    } else {
      log("Something went wrong${response.reasonPhrase} ${response.statusCode}");
    }

    return stocks;
  }

  Future<void> deleteStore({required String id}) async {
    var token = await LocalStorageServices().getId();
    final response = await http.delete(
      Uri.parse("${_urls.operationStoreUrl}/$id"),
      headers: {
        ..._urls.headers,
        "Authorization": token,
      },
    );
    if (response.statusCode == 200) {
      log("Deleted");
    } else {
      log("Something went wrong ${response.statusCode}");
    }
  }

  Future<void> updateStore(
      {required String id, required Map<String, dynamic> updatedStore}) async {
    var token = await LocalStorageServices().getId();
    final response = await http.patch(
      Uri.parse("${_urls.operationStoreUrl}/$id"),
      headers: {
        ..._urls.headers,
        "Authorization": token,
      },
      body: jsonEncode(updatedStore),
    );

    if (response.statusCode == 200) {
      log("Updated");
    } else {
      log("Something went wrong ${response.statusCode}");
    }
  }
}

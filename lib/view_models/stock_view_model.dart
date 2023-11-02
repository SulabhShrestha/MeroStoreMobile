import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:merostore_mobile/models/stock_model.dart';
import 'package:merostore_mobile/services/stock_web_services.dart';

class StockViewModel {
  final _stockWebServices = StockWebServices();

  /// if the material name, price is same then it is updated.
  Future<void> addNewStock({
    required Map<String, dynamic> userInput,
    required Function(StockModel store) onStockAdded,
    required VoidCallback onFailure,
    required Function(Map<String, dynamic> store) onUpdated,
  }) async {
    Map<String, dynamic> res =
        await _stockWebServices.addNewData(userInput: userInput);

    if (res["isSaved"] ?? false) {
      onStockAdded(res["data"]);
    } else if (res["isUpdated"] ?? false) {
      onUpdated(res["data"]);
    } else {
      onFailure();
    }
  }

  /// Deletes stock
  /// returns success or not found message
  Future<void> deleteStock(
      {required String storeId, required String stockId}) async {
    int statusCode =
        await _stockWebServices.deleteStock(stockId: stockId, storeId: storeId);

    if (statusCode == 404) {
      throw "Stock not found";
    }
  }

  /// Updates the stock
  Future<Map<String, dynamic>> updateStock({
    required String storeId,
    required String stockId,
    required Map<String, dynamic> userInput,
  }) async {
    final response = await _stockWebServices.updateStock(
        stockId: stockId, storeId: storeId, userInput: userInput);

    if (response.statusCode == 404) {
      throw "Stock not found";
    }
    return jsonDecode(response.body);
  }

  Future<List<StockModel>> getAllStocks() async {
    return _stockWebServices.getAllStocks();
  }

  Future<List<String>> getAllMaterialNames({required String storeName}) async {
    return _stockWebServices.getAllMaterialNames(storeName: storeName);
  }
}

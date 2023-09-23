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
    required Function(StockModel store) onUpdated,
  }) async {
    Map<String, dynamic> res =
        await _stockWebServices.addNewData(userInput: userInput);

    if (res["isAdded"]) {
      onStockAdded(res["data"]);
    } else if (res["isUpdated"]) {
      onUpdated(res["data"]);
    } else {
      onFailure();
    }
  }

  Future<List<StockModel>> getAllStocks() async {
    return _stockWebServices.getAllStocks();
  }

  Future<List<String>> getAllMaterialNames({required String storeName}) async {
    return _stockWebServices.getAllMaterialNames(storeName: storeName);
  }
}

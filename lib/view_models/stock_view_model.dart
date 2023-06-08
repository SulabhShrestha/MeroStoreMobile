import 'dart:ui';

import 'package:merostore_mobile/models/stock.dart';
import 'package:merostore_mobile/services/stock_web_services.dart';

class StockViewModel {
  final _stockWebServices = StockWebServices();

  Future<void> addNewStock({
    required Map<String, dynamic> userInput,
    required VoidCallback onStockAdded,
    required VoidCallback onFailure,
  }) async {
    bool isAdded = await _stockWebServices.addNewData(userInput: userInput);

    if (isAdded) {
      onStockAdded();
    } else {
      onFailure();
    }
  }

  Future<List<Stock>> getAllStocks() async {
    return _stockWebServices.getAllStocks();
  }

  Future<List<String>> getAllMaterialNames({required String storeName}) async {
    return _stockWebServices.getAllMaterialNames(storeName: storeName);
  }
}

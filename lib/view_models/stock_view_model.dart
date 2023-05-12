import 'dart:ui';

import 'package:merostore_mobile/services/stock_web_services.dart';

class StockViewModel {
  Future<void> addNewStock({
    required Map<String, dynamic> userInput,
    required VoidCallback onStockAdded,
    required VoidCallback onFailure,
  }) async {
    bool isAdded = await StockWebServices().addNewData(userInput: userInput);

    if (isAdded) {
      onStockAdded();
    } else {
      onFailure();
    }
  }
}

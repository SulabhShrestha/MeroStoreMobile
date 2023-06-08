import 'dart:ui';


import 'package:merostore_mobile/services/sales_web_services.dart';


class SalesViewModel {
  final _salesWebServices = SalesWebServices();

  Future<void> addNewSales({
    required Map<String, dynamic> userInput,
    required VoidCallback onStockAdded,
    required VoidCallback onFailure,
  }) async {
    bool isAdded = await _salesWebServices.addNew(userInput: userInput);

    if (isAdded) {
      onStockAdded();
    } else {
      onFailure();
    }
  }
}
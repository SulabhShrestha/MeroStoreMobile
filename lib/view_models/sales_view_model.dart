import 'dart:ui';


import 'package:merostore_mobile/models/sales_model.dart';
import 'package:merostore_mobile/services/sales_web_services.dart';


class SalesViewModel {
  final _salesWebServices = SalesWebServices();

  /// Add new sales to the database
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

  /// Return all the sales record
  Future<List<Sales>> getAllSales() async {
    return _salesWebServices.getAllSalesRecords();
  }
}
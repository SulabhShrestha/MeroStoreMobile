import 'dart:ui';

import 'package:merostore_mobile/models/sales_model.dart';
import 'package:merostore_mobile/services/sales_web_services.dart';

class SalesViewModel {
  final _salesWebServices = SalesWebServices();

  /// Add new sales to the database
  Future<void> addNewSales({
    required Map<String, dynamic> userInput,
    required VoidCallback onStockAdded,
    required Function(String) onFailure,
  }) async {
    Map<String, dynamic> res =
        await _salesWebServices.addNew(salesRecord: userInput);

    if (res["isAdded"]) {
      onStockAdded();
    } else {
      onFailure(res["desc"]);
    }
  }

  /// Return all the sales record
  Future<List<Sales>> getAllSales() async {
    return _salesWebServices.getAllSalesRecords();
  }
}

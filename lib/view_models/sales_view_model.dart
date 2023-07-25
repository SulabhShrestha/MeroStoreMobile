import 'dart:ui';

import 'package:dartx/dartx.dart';
import 'package:merostore_mobile/models/sales_model.dart';
import 'package:merostore_mobile/services/sales_web_services.dart';
import 'package:merostore_mobile/utils/arrangement_order.dart';

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
  Future<List<Sales>> getAllSales({ArrangementOrder? arrangementOrder}) async {
    var allSalesRecord = await _salesWebServices.getAllSalesRecords();

    if (arrangementOrder == null) {
      return allSalesRecord;
    } else if (arrangementOrder == ArrangementOrder.ascending) {
      final sorted =
          allSalesRecord.sortedBy((sales) => sales.details["Total Price"]);
      return sorted;
    }

    // descending
    return allSalesRecord
        .sortedByDescending((sales) => sales.details["Total Price"]);
  }
}

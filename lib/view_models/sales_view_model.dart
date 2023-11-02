import 'dart:convert';
import 'dart:ui';

import 'package:dartx/dartx.dart';
import 'package:merostore_mobile/models/sales_model.dart';
import 'package:merostore_mobile/services/sales_web_services.dart';
import 'package:merostore_mobile/utils/arrangement_order.dart';

class SalesViewModel {
  final _salesWebServices = SalesWebServices();

  /// Add new sales to the database
  Future<SalesModel> addNewSales({
    required Map<String, dynamic> userInput,
  }) async {
    Map<String, dynamic> res =
        await _salesWebServices.addNew(salesRecord: userInput);

    if (res["isAdded"]) {
      return res["data"];
    }

    throw res["desc"];
  }

  /// Return all the sales record
  Future<List<SalesModel>> getAllSales(
      {ArrangementOrder? arrangementOrder}) async {
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

  /// deletes the sales record
  Future<void> deleteSales({
    required String storeId,
    required String salesId,
  }) async {
    int statusCode =
        await _salesWebServices.deleteSales(storeId: storeId, salesId: salesId);

    if (statusCode == 404) {
      throw "Sales record not found";
    }
  }

  /// updates the sales record
  Future<Map<String, dynamic>> updateSales({
    required String storeId,
    required String salesId,
    required Map<String, dynamic> userInput,
  }) async {
    final response = await _salesWebServices.updateSales(
        storeId: storeId, salesId: salesId, userInput: userInput);

    if (response.statusCode == 404) {
      throw "Sales record not found";
    }

    return jsonDecode(response.body);
  }
}

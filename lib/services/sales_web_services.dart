import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:merostore_mobile/exceptions/custom_exception.dart';
import 'package:merostore_mobile/models/sales_model.dart';
import 'package:merostore_mobile/utils/constants/messages_constant.dart';
import 'package:merostore_mobile/views/today_sold_page/today_sold_page.dart';

import 'stock_web_services.dart';

/// Handles everything related to [TodaySoldPage]
///
class SalesWebServices {
  final _headers = {"Content-Type": "application/json"};
  final _stockWebServices = StockWebServices();

  /// Adds new sales to the database
  ///
  /// Returns true (in isAdded) if the sales record is added successfully,
  /// desc is not added if when it's added to the db
  ///
  /// Returns desc (in desc) if any type of error is occurred
  Future<Map<String, dynamic>> addNew(
      {required Map<String, dynamic> salesRecord}) async {
    try {
      await _validateMaterial(
          materialName: salesRecord["details"]["Material Name"],
          storeName: salesRecord["Store Name"]);
    } on CustomException catch (e) {

      return {
        "isAdded": false,
        "desc": e.message,
      }; // Material not present, so returning false
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/sales/addNew'),
      headers: _headers,
      body: json.encode(salesRecord),
    );
    if (response.statusCode == 200) {
      return {"isAdded": true};
    } else {

      return {
        "isAdded": false,
        "desc": MessagesConstant().somethingWentWrong,
      };
    }
  }

  /// Returns all the sales record
  Future<List<Sales>> getAllSalesRecords() async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:3000/sales/"),
      headers: _headers,
    );

    List<Sales> sales = [];

    if (response.statusCode == 200) {
      log("Response: ${response.body}");
      for (Map<String, dynamic> elem in jsonDecode(response.body)) {
        sales.add(Sales.fromJSON(elem));
      }
    } else {
      log("Something went wrong");
    }

    log("Sales records: $sales");

    return sales;
  }

  /// Validating if the material that the user had sold is present or not in the db
  /// true means material is present, and can proceed to add new sales record
  /// false means material is not present
  Future<void> _validateMaterial(
      {required String materialName, required String storeName}) async {
    var allMaterials =
        await _stockWebServices.getAllMaterialNames(storeName: storeName);
    if (!allMaterials.contains(materialName)) {
      throw CustomException(MessagesConstant().materialNotFound);
    }
  }
}

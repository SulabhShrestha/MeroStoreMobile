import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:merostore_mobile/exceptions/custom_exception.dart';
import 'package:merostore_mobile/models/sales_model.dart';
import 'package:merostore_mobile/utils/constants/messages_constant.dart';
import 'package:merostore_mobile/utils/constants/urls_constant.dart';
import 'package:merostore_mobile/views/today_sold_page/today_sold_page.dart';

import 'local_storage_services.dart';
import 'stock_web_services.dart';

/// Handles everything related to [TodaySoldPage]
///
class SalesWebServices {
  final _stockWebServices = StockWebServices();
  final _urls = UrlsConstant();

  /// Returns all the sales record
  Future<List<SalesModel>> getAllSalesRecords() async {
    var token = await LocalStorageServices().getId();
    final response = await http.get(
      Uri.parse(_urls.allSalesUrl),
      headers: {
        ..._urls.headers,
        "Authorization": token,
      },
    );

    List<SalesModel> sales = [];

    if (response.statusCode == 200) {
      for (Map<String, dynamic> elem in jsonDecode(response.body)) {
        sales.add(SalesModel.fromJSON(elem));
      }
    } else {
      log("Something went wrong");
    }

    return sales;
  }

  /// Adds new sales to the database
  ///
  /// Returns true (in isAdded) if the sales record is added successfully,
  /// desc is not added if when it's added to the db
  ///
  /// Returns desc (in desc) if any type of error is occurred
  Future<Map<String, dynamic>> addNew(
      {required Map<String, dynamic> salesRecord}) async {
    var token = await LocalStorageServices().getId();

    final response = await http.post(
      Uri.parse(_urls.addSalesUrl),
      headers: {..._urls.headers, "Authorization": token},
      body: json.encode(salesRecord),
    );

    if (response.statusCode == 201) {
      return {
        "isAdded": true,
        "data": SalesModel.fromJSON(jsonDecode(response.body))
      };
    } else {
      return {
        "isAdded": false,
        "desc": MessagesConstant().somethingWentWrong,
      };
    }
  }

  /// Validating if the material that the user had sold is present or not in the db

  Future<void> _validateMaterial(
      {required String materialName, required String storeName}) async {
    var allMaterials =
        await _stockWebServices.getAllMaterialNames(storeName: storeName);
    if (!allMaterials.contains(materialName)) {
      throw CustomException(MessagesConstant().materialNotFound);
    }
  }

  /// Validating if the sold material is in stock or not,
  /// and also if the volume is greater or not
  ///
  Future<void> _validateQuantity(
      {required String materialName,
      required String storeName,
      required int quantitySold}) async {
    try {
      var materialDetails = await _stockWebServices.getMaterialDetails(
          storeName: storeName, materialName: materialName);

      // trying to sold more than we have
      if (quantitySold >
          int.parse(materialDetails["details"]["Brought Quantity"])) {
        throw CustomException(MessagesConstant().soldQuantityExceeded);
      }

      log("allMaterial: $materialDetails");
    } on FormatException catch (e) {
      if (e.source.contains("material")) {
        // in case of material not found exception, source = "No material found
        throw CustomException(MessagesConstant().materialNotFound);
      }
      log("catch: $e");
    }
  }

  /// Deletes the sales record
  Future<int> deleteSales(
      {required String storeId, required String salesId}) async {
    var token = await LocalStorageServices().getId();

    final response = await http.delete(
      Uri.parse("${_urls.allSalesUrl}$storeId/$salesId"),
      headers: {..._urls.headers, "Authorization": token},
    );

    return response.statusCode;
  }

  /// Updates the sales
  Future<Response> updateSales(
      {required String storeId,
      required String salesId,
      required Map<String, dynamic> userInput}) async {
    var token = await LocalStorageServices().getId();
    var url = "${_urls.allSalesUrl}$storeId/$salesId";
    final response = await http.patch(
      Uri.parse(url),
      headers: {
        ..._urls.headers,
        "Authorization": token,
      },
      body: json.encode(userInput),
    );

    return response;
  }
}

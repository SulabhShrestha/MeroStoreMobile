import 'package:flutter/material.dart';

/// Helper class responsible for assisting [StockPage]
class StockHelper {
  List<String> getTransactionTypes() {
    return ["Cash", "Credit", "Prepaid", "Return"];
  }

  List<Map> _getCashInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
        "dataType": String,
      },
      {
        "heading": "Brought Quantity",
        "required": true,
        "quantityOption": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
      },
      {
        "heading": "Total Price",
        "required": true,
        "keyboardType": TextInputType.number,
        "dataType": double,
      },
      {
        "heading": "Description",
        "required": false,
        "dataType": String,
      },
    ];
  }

  List<Map> _getCreditInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
        "dataType": String,
      },
      {
        "heading": "Sold Quantity",
        "required": true,
        "quantityOption": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
      },
      {
        "heading": "Total Price",
        "required": true,
        "keyboardType": TextInputType.number,
        "dataType": double,
      },
      {
        "heading": "Creditor's Name",
        "required": true,
        "dataType": String,
      },
      {
        "heading": "Creditor's Information",
        "required": false,
        "dataType": String,
      },
      {
        "heading": "Description",
        "required": false,
        "dataType": String,
      },
    ];
  }

  List<Map> _getPrepaidInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
        "dataType": String,
      },
      {
        "heading": "For Quantity",
        "required": true,
        "quantityOption": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
      },
      {
        "heading": "Money Given",
        "required": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
      },
      {
        "heading": "Debtor's Name",
        "required": true,
        "dataType": String,
      },
      {
        "heading": "Debtor's Information",
        "required": false,
        "dataType": String,
      },
      {
        "heading": "Description",
        "required": false,
        "dataType": String,
      },
    ];
  }

  List<Map> _getReturnInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
        "dataType": String,
      },
      {
        "heading": "Returned Quantity",
        "required": true,
        "quantityOption": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
      },
      {
        "heading": "Returned Amount",
        "required": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
      },
      {
        "heading": "Description",
        "required": false,
        "dataType": String,
      },
    ];
  }

  List<Map> getInformation({required String transactionType}) {
    switch (transactionType.toLowerCase()) {
      case "cash":
        return _getCashInformation();

      case "credit":
        return _getCreditInformation();

      case "prepaid":
        return _getPrepaidInformation();

      case "return":
        return _getReturnInformation();

      default:
        return [];
    }
  }
}

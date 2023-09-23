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
        "fieldName": "materialName", // used for sending data to the db
      },
      {
        "heading": "Brought Quantity",
        "required": true,
        "quantityOption": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
        "fieldName": "broughtQuantity",
      },
      {
        "heading": "Total Price",
        "required": true,
        "keyboardType": TextInputType.number,
        "dataType": double,
        "fieldName": "totalPrice",
      },
      {
        "heading": "Description",
        "required": false,
        "dataType": String,
        "fieldName": "description",
      },
    ];
  }

  List<Map> _getCreditInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
        "dataType": String,
        "fieldName": "materialName",
      },
      {
        "heading": "Sold Quantity",
        "required": true,
        "quantityOption": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
        "fieldName": "soldQuantity",
      },
      {
        "heading": "Total Price",
        "required": true,
        "keyboardType": TextInputType.number,
        "dataType": double,
        "fieldName": "totalPrice",
      },
      {
        "heading": "Creditor's Name",
        "required": true,
        "dataType": String,
        "fieldName": "creditorName",
      },
      {
        "heading": "Creditor's Information",
        "required": false,
        "dataType": String,
        "fieldName": "creditorInformation",
      },
      {
        "heading": "Description",
        "required": false,
        "dataType": String,
        "fieldName": "description",
      },
    ];
  }

  List<Map> _getPrepaidInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
        "dataType": String,
        "fieldName": "materialName",
      },
      {
        "heading": "For Quantity",
        "required": true,
        "quantityOption": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
        "fieldName": "forQuantity",
      },
      {
        "heading": "Money Given",
        "required": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
        "fieldName": "moneyGiven",
      },
      {
        "heading": "Debtor's Name",
        "required": true,
        "dataType": String,
        "fieldName": "debtorName",
      },
      {
        "heading": "Debtor's Information",
        "required": false,
        "dataType": String,
        "fieldName": "debtorInformation",
      },
      {
        "heading": "Description",
        "required": false,
        "dataType": String,
        "fieldName": "description",
      },
    ];
  }

  List<Map> _getReturnInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
        "dataType": String,
        "fieldName": "materialName",
      },
      {
        "heading": "Returned Quantity",
        "required": true,
        "quantityOption": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
        "fieldName": "returnedQuantity",
      },
      {
        "heading": "Returned Amount",
        "required": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
        "fieldName": "returnedAmount",
      },
      {
        "heading": "Description",
        "required": false,
        "dataType": String,
        "fieldName": "description",
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

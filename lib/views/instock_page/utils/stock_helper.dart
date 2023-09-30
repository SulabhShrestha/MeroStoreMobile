import 'package:flutter/material.dart';

/// Helper class responsible for assisting [StockPage]
class StockHelper {
  List<String> getTransactionTypes() {
    return ["Cash", "Credit", "Prepaid"];
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
        "dataType": double,
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
        "heading": "Brought Quantity",
        "required": true,
        "quantityOption": true,
        "keyboardType": TextInputType.number,
        "dataType": double,
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

  List<Map> getInformation({required String transactionType}) {
    switch (transactionType.toLowerCase()) {
      case "cash":
        return _getCashInformation();

      case "credit":
        return _getCreditInformation();

      default:
        return [];
    }
  }

  // store heading that is not to be displayed
  List<String> getBlacklistedHeading() {
    return <String>[
      "broughtQuantityType",
      "creditorInformation",
      "debtorInformation",
      "description"
    ];
  }

  // returns heading that will contains numeric values
  List<String> getHeadingContainingNumericValue() {
    return <String>[
      "broughtQuantity",
      "totalPrice",
      "soldQuantity",
      "broughtQuantity",
      "moneyGiven",
      "forQuantity",
      "returnedQuantity",
      "returnedAmount",
    ];
  }
}

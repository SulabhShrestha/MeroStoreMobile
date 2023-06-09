import 'package:flutter/material.dart';

/// Helper class responsible for assisting [SalesPage]
class SalesHelper {
  List<String> getTransactionTypes() {
    return ["Cash", "Credit", "Prepaid", "Return", "Settlement", "Deposited"];
  }

  List<Map> _getCashInformation() {
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
        "dataType": int,
        "keyboardType": TextInputType.number,
      },
      {
        "heading": "Total Price",
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

  List<Map> _getPrepaidInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
        "dataType": String,
      },
      {
        "heading": "For Quantity",
        "required": false,
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

  List<Map> _getSettlementInformation() {
    return [
      {
        "heading": "Debtor Name",
        "required": true,
        "dataType": String,
      },
      {
        "heading": "Money Given",
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

  List<Map> _getDepositedInformation() {
    return [
      {
        "heading": "Organization Name",
        "required": true,
        "dataType": String,
      },
      {
        "heading": "Amount",
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

      case "settlement":
        return _getSettlementInformation();

      case "deposited":
        return _getDepositedInformation();

      default:
        return [];
    }
  }
}

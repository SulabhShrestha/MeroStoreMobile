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
        "fieldName": "materialName", // field name in db
      },
      {
        "heading": "Sold Quantity",
        "required": true,
        "quantityOption": true,
        "dataType": int,
        "keyboardType": TextInputType.number,
        "fieldName": "soldQuantity",
      },
      {
        "heading": "Total Price",
        "required": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
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
        "dataType": int,
        "fieldName": "totalPrice",
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
        "required": false,
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

  List<Map> _getSettlementInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
        "dataType": String,
        "fieldName": "materialName",
      },
      {
        "heading": "Debtor Name",
        "required": true,
        "dataType": String,
        "fieldName": "debtorName",
      },
      {
        "heading": "Money Given",
        "required": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
        "fieldName": "moneyGiven",
      },
      {
        "heading": "Description",
        "required": false,
        "dataType": String,
        "fieldName": "description",
      },
    ];
  }

  List<Map> _getDepositedInformation() {
    return [
      {
        "heading": "Organization Name",
        "required": true,
        "dataType": String,
        "fieldName": "organizationName",
      },
      {
        "heading": "Amount",
        "required": true,
        "keyboardType": TextInputType.number,
        "dataType": int,
        "fieldName": "amount",
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

      case "settlement":
        return _getSettlementInformation();

      case "deposited":
        return _getDepositedInformation();

      default:
        return [];
    }
  }

  // heading that is not to be displayed
  List<String> getBlacklistedHeading() {
    return <String>[
      "soldQuantityType",
      "creditorInformation",
      "debtorInformation",
      "description"
    ];
  }

  // returns heading that will contains numeric values
  List<String> getHeadingContainingNumericValue() {
    return <String>[
      "soldQuantity",
      "totalPrice",
      "forQuantity",
      "moneyGiven",
      "returnedQuantity",
      "returnedAmount",
      "amount",
    ];
  }
}

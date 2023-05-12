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
      },
      {
        "heading": "Sold Quantity",
        "required": true,
        "quantityOption": true,
        "keyboardType": TextInputType.number,
      },
      {
        "heading": "Total Price",
        "required": true,
        "keyboardType": TextInputType.number,
      },
      {
        "heading": "Description",
        "required": false,
      },
    ];
  }

  List<Map> _getCreditInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
      },
      {
        "heading": "Sold Quantity",
        "required": true,
        "quantityOption": true,
        "keyboardType": TextInputType.number,
      },
      {
        "heading": "Total Price",
        "required": true,
        "keyboardType": TextInputType.number,
      },
      {
        "heading": "Debtor's Name",
        "required": true,
      },
      {
        "heading": "Debtor's Information",
        "required": false,
      },
      {
        "heading": "Description",
        "required": false,
      },
    ];
  }

  List<Map> _getPrepaidInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
      },
      {
        "heading": "For Quantity",
        "required": false,
        "quantityOption": true,
        "keyboardType": TextInputType.number,
      },
      {
        "heading": "Money Given",
        "required": true,
        "keyboardType": TextInputType.number,
      },
      {
        "heading": "Creditor's Name",
        "required": true,
      },
      {
        "heading": "Creditor's Information",
        "required": false,
      },
      {
        "heading": "Description",
        "required": false,
      },
    ];
  }

  List<Map> _getReturnInformation() {
    return [
      {
        "heading": "Material Name",
        "required": true,
      },
      {
        "heading": "Returned Quantity",
        "required": true,
        "quantityOption": true,
        "keyboardType": TextInputType.number,
      },
      {
        "heading": "Returned Amount",
        "required": true,
        "keyboardType": TextInputType.number,
      },
      {
        "heading": "Description",
        "required": false,
      },
    ];
  }

  List<Map> _getSettlementInformation() {
    return [
      {
        "heading": "Debtor Name",
        "required": true,
      },
      {
        "heading": "Money Given",
        "required": true,
        "keyboardType": TextInputType.number,
      },
      {
        "heading": "Description",
        "required": false,
      },
    ];
  }

  List<Map> _getDepositedInformation() {
    return [
      {
        "heading": "Organization Name",
        "required": true,
      },
      {
        "heading": "Amount",
        "required": true,
        "keyboardType": TextInputType.number,
      },
      {
        "heading": "Description",
        "required": false,
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
